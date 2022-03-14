//
//  APODModel.swift
//  APOD
//
//  Created by Ankit Sharma on 11/03/22.
//

import Foundation

struct APODModelResponse: Codable {
    
    var concepts: String?
    var copyright: String?
    var date: String
    var explanation: String?
    var hdurl: String?
    var mediaType: MediaType?
    var serviceVersion: String?
    var title: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case concepts
        case copyright
        case date
        case explanation
        case hdurl
        case title
        case url
        case mediaType = "media_type"
        case serviceVersion = "service_version"
    }
}


enum MediaType: String, Codable {
    case video
    case image
}
