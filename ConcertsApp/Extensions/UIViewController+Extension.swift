//
//  UIViewController+Extension.swift
//  ConcertsApp
//
//  Created by Harun on 5.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
    
    func showAlertDefault(with title: String? = nil,
                          message: String,
                          actions: ((_ alertController: UIAlertController) -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            actions(alertController)
        } else {
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                alertController.dismiss(animated: true, completion: nil)
            }))
        }
        present(alertController, animated: true, completion: nil)
    }
}
