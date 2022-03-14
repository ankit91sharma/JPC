//
//  NetworkManager.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation

typealias serviceResponse = (Result<Any, NetworkError>) -> Void

class APIManager {
    
    static let sharedInstance = APIManager()
    private init() {}
    
    func callService(_ service: Service, withCallback serviceResponse: @escaping serviceResponse) {
        URLSession.shared.dataTask(with: createRequest(service)) { data, response, error in
            guard let data = data, error == nil else {
                serviceResponse(.failure(NetworkError.badRequest))
                return
            }
            if let parser = service.parser
            {
                if let parsedData = parser.parse(data) {
                    switch parsedData {
                    case is NSError:
                        serviceResponse(.failure(NetworkError.unknown))
                    default:
                        serviceResponse(.success(parsedData))
                    }
                } else {
                    serviceResponse(.failure(NetworkError.invalidJson))
                }
            }
        }.resume()
    }
        
    fileprivate func createRequest(_ service: Service) -> URLRequest {
        let request = NSMutableURLRequest()
        guard let requestParams = service.params else { return request as URLRequest }
        
        if requestParams.count > 0 {
            if let data = RequestSerializerForm().serialize(requestParams as Any) {
                    if let vars = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? {
                        request.url = URL(string: service.requestUrl+vars)
                    }
            }
        }
        return request as URLRequest
    }
}
