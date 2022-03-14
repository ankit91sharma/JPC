//
//  Enviroment.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation

public struct Enviroment {
    
    private static var infoDic: [String: Any] {
        guard let dic = Bundle.main.infoDictionary else { fatalError("Plist not found") }
        return dic
    }
    
    static var apiKey: String {
        guard let key = Enviroment.infoDic["API_KEY"] as? String else { fatalError("API Key not found") }
        return key
    }
}
