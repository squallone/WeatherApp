//
//  UIAlertController+Settings.swift
//  WeatherAPI
//
//  Created by Abdiel Soto on 15/11/24.
//

import UIKit

extension UIAlertController {
  struct Settings {
    var title: String?
    var message: String?
    var style: UIAlertController.Style = .alert
    var interfaceStyle: UIUserInterfaceStyle?
    var actions: [Action] = [Action()]
    var target: UIViewController?

    struct Action {
      var title: String? = "OK"
      var style: UIAlertAction.Style = .default
      var completion: ((UIAlertAction) -> Void)?
    }
  }

  /// Present alert controller
  /// - Parameters:
  ///   - settings: Alert settings
  ///   - animated: Present animated or not
  ///   - completion: Completion handler
  static func present(_ settings: Settings, animated: Bool = true, completion: (() -> Void)? = nil) {
    let controller = UIAlertController(title: settings.title, message: settings.message, preferredStyle: settings.style)
    controller.overrideUserInterfaceStyle = settings.interfaceStyle ?? .unspecified

    for action in settings.actions {
      let alertAction = UIAlertAction(title: action.title, style: action.style, handler: action.completion)
      controller.addAction(alertAction)
    }

    DispatchQueue.main.async {
      let target = settings.target
      target?.present(controller, animated: animated, completion: completion)
    }
  }
}
