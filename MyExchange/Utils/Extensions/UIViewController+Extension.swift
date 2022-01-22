//
//  UIViewController+Extension.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 23.01.2022.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String? = "Unknown Error") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertButton)
        self.present(alert, animated: true)
    }
}
