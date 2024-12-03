//
//  UIConfigurator.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 14/11/24.
//

import UIKit

struct UIConfigurator {
    
    static func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundEffect = UIBlurEffect(style: .light)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
