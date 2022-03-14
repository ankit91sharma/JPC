//
//  GenericParser.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation

public protocol Parser {
    func parse(_ data: Data) -> Any?
}

class GenericParser<T: Decodable>: Parser {
    func parse(_ data: Data) -> Any? {
        do {
            let decodeData = try JSONDecoder().decode(T.self, from: data) as T
            return decodeData
        } catch let error as NSError {
            print("error parsing data: \(error.debugDescription)")
            return nil
        }
    }
}
