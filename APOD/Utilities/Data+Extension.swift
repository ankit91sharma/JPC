//
//  Data+Extension.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation
import UIKit

extension Data {
    func convertDataToImage() -> UIImage? {
        return UIImage(data: self)
    }
}
