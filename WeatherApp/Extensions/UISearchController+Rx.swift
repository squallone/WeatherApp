//
//  UISearchController+Rx.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 14/11/24.
//

import RxSwift
import RxCocoa
import UIKit

final class RxSearchResultsUpdaterProxy: DelegateProxy<UISearchController, UISearchResultsUpdating>, UISearchResultsUpdating {

    lazy var searchPhraseSubject = PublishSubject<String>()
    
    init(searchController: UISearchController) {
        super.init(parentObject: searchController, delegateProxy: RxSearchResultsUpdaterProxy.self)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchPhraseSubject.onNext(searchController.searchBar.text ?? "")
    }
}

extension RxSearchResultsUpdaterProxy: DelegateProxyType {
    static func currentDelegate(for object: UISearchController) -> UISearchResultsUpdating? {
        return object.searchResultsUpdater
    }
    
    static func setCurrentDelegate(_ delegate: UISearchResultsUpdating?, to object: UISearchController) {
        object.searchResultsUpdater = delegate
    }
    
    static func registerKnownImplementations() {
        register { RxSearchResultsUpdaterProxy(searchController: $0) }
    }
}

public extension Reactive where Base: UISearchController {
    
    var delegate: DelegateProxy<UISearchController, UISearchResultsUpdating> {
        return RxSearchResultsUpdaterProxy.proxy(for: base)
    }
    
    var searchText: Observable<String> {
        return RxSearchResultsUpdaterProxy.proxy(for: base).searchPhraseSubject.asObservable()
    }
}
