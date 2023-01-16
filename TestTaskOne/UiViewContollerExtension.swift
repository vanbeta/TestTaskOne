//
//  UiViewContollerExtension.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 16.01.2023.
//

import Foundation
import UIKit


extension UIViewController {
    func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
