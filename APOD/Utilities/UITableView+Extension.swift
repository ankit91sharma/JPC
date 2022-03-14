//
//  UITableView+Extension.swift
//  APOD
//
//  Created by Ankit Sharma on 11/03/22.
//

import Foundation
import UIKit

protocol TypeName: AnyObject {
    static var typeName: String { get }
}

extension NSObject: TypeName {
    public class var typeName: String {
        let type = String(describing: self)
        return type
    }
}

extension UITableView {
    func registerCells() {
        self.register(UINib(nibName: APODImageTableViewCell.typeName, bundle: nil),
                      forCellReuseIdentifier: APODImageTableViewCell.typeName)
    }
}
