//
//  Date+Extension.swift
//  APOD
//
//  Created by Ankit Sharma on 13/03/22.
//

import Foundation

extension Date {
     func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .init(identifier: .iso8601)
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
       
    }
}
