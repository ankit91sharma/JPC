//
//  Errors.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation

enum NetworkError: Error {
    case invalidData
    case invalidJson
    case badRequest
    case unknown
    case invalidURL
}
