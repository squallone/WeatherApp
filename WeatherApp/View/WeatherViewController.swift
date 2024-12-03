//
//  ViewController.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 14/11/24.
//

import MapKit
import RxCocoa
import RxSwift
import UIKit

final class WeatherCoordinator: Coordinator {
    func start() {
        
    }
}


protocol Coordinator {
    func start()
}

final class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: WatherViewModeling
    private let disposeBag = DisposeBag()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = nil
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search city"
        return searchController
    }()
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        let width = activityIndicatorView.frame.width
        blurEffectView.frame = CGRectMake(0, 0, width * 2, width * 2)
        blurEffectView.center = activityIndicatorView.center
        blurEffectView.layer.cornerRadius = width / 4
        blurEffectView.clipsToBounds = true

        activityIndicatorView.insertSubview(blurEffectView, at: 0)
        return activityIndicatorView
    }()
    
    // MARK: - Initialization
    
    init(viewModel: WatherViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        view.backgroundColor = .blue
        navigationItem.searchController = searchController
        configureConstraints()
        configureBindings()
    }
    
    // MARK: - Private
    
    private func configureBindings() {
        searchController.searchBar.rx.text.orEmpty
            .bind(to: viewModel.inputs.searchTextRelay)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.searchButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.viewModel.inputs.search()
                self?.viewModel.inputs.forecast()
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel.outputs.error
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showAlert(text: error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.weatherData
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                [weak self] weather in
                guard let self else { return }
                mapView.centerToLocation(
                    CLLocation(
                        latitude: weather.city.latitude,
                        longitude: weather.city.longitude
                    )
                )
                
                showTempertureSheet(weather: weather)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureConstraints() {
        view.addSubview(mapView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func showTempertureSheet(weather: Weather) {
            let sheetViewController = TempertureViewController(viewModel: TempertureViewModel(weather: weather))
            present(sheetViewController, animated: true, completion: nil)
        }
    
    private func showAlert(text: String) {
        let settings = UIAlertController.Settings(
          title: "Something Went Wrong",
          message: text,
          target: self
        )

        UIAlertController.present(settings)
    }
}

