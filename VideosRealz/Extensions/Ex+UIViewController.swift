//
//  Ex+UIViewController.swift
//  VideosRealz
//
//  Created by User on 24/08/2022.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(with title: String, and message: String, completionHandler: ((UIAlertAction)->(Void))?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: completionHandler)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

