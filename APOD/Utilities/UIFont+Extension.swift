//
//  UIFont+Extension.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation
import UIKit

extension UIFont {
    func scriptFont(size: CGFloat, boldRequired: Bool = false) -> UIFont {
      let f =  boldRequired ?  "HelveticaNeue-Bold" : "HelveticaNeue-Regular"
      guard let customFont = UIFont(name: f, size: size) else {
        return UIFont.systemFont(ofSize: size)
      }
      return customFont
    }
}
