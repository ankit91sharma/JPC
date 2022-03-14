//
//  BaseService.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation

class BaseService: Service {
    
    var baseUrl = APODAPIConstants.baseURL
    var requestType: RequestType = .GET
    var requestUrl: String = ""
    var params: [String : String]?
    var parser: Parser?
    
    init() {
        self.requestUrl = baseUrl
    }
}
