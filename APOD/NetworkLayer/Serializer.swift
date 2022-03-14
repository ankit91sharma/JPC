//
//  Serializer.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation

protocol RequestSerializer {
    func serialize(_ object: Any) -> Data?
}

class RequestSerializerForm: RequestSerializer {

    func serialize(_ object: Any) -> Data? {
        var formData: Data?
        if let params = object as? Dictionary<String, Any> {
            var body = ""
            for (key, value) in params {
                let encodedKey = urlEncode(key)
                let encodedValue = urlEncode(value as! String)
                body += encodedKey+"="+encodedValue+"&"
            }
            body = String(body[body.startIndex..<body.endIndex])
            formData = body.data(using: String.Encoding.utf8)
        }
        return formData
    }
    
    func urlEncode(_ string: String) -> String {
        guard let encoded = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return string
        }
        return encoded
    }
}
