//
//  Service.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation

public enum RequestType: String {
    case GET
}

protocol Service {
    var baseUrl: String { set get }
    var requestType: RequestType { get }
    var requestUrl: String { get }
    var params: [String: String]? { get }
    var parser: Parser? { get }
}
