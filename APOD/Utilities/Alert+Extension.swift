//
//  Alert+Extension.swift
//  APOD
//
//  Created by Ankit Sharma on 14/03/22.
//

import Foundation
import UIKit
extension UIAlertController {

    static func showAlertMessage(vc: UIViewController, title:String? = nil, message:String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        vc.present(alert, animated: true, completion: nil)
    }
}
