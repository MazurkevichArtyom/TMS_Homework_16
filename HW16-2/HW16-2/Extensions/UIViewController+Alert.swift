//
//  UIViewController+Alert.swift
//  HW16-2
//
//  Created by Artem Mazurkevich on 25.02.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String, okButtonText: String, cancelButtonText: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okButtonText, style: .default)
        alert.addAction(okAction)
        
        if let cancelText = cancelButtonText {
            let cancleAction = UIAlertAction(title: cancelText, style: .cancel)
            alert.addAction(cancleAction)
        }
        
        present(alert, animated: true)
    }
}
