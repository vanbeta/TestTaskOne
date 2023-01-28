//
//  ViewCcontrollerExtension.swift
//  TestTaskOne
//
//  Created by Ivan Poderegin on 22.01.2023.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showRemoveAlert(with title: String, and message: String,  _ completion: @escaping (Bool) -> ()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Пропустить", style: .default) { (action: UIAlertAction!) in
            completion(false)
        })
        alertController.addAction(UIAlertAction(title: "Сохранить", style: .cancel) { (action: UIAlertAction!) in
            completion(true)
        })
        self.present(alertController, animated: true, completion: nil)
    }
}
