//
//  ForecastViewController.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import UIKit
import SwiftUI

final class TempertureViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: TempertureViewModel
    
    // MARK: - Initialization
    init(viewModel: TempertureViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureSheet()
    }
    
    // MARK: - Private
    private func configureView() {
        
        let vc = UIHostingController(rootView: TempertureView(viewModel: viewModel))
        guard let swiftuiView = vc.view else { return }
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(vc)
        view.addSubview(swiftuiView)
        
        NSLayoutConstraint.activate([
            swiftuiView.topAnchor.constraint(equalTo: view.topAnchor),
            swiftuiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftuiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftuiView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        vc.didMove(toParent: self)
    }
    
    private func configureSheet() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            
            presentationController.prefersGrabberVisible = true
        }
    }
}
