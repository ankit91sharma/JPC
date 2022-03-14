//
//  ImageDownloader.swift
//  APOD
//
//  Created by Ankit Sharma on 14/03/22.
//

import Foundation

class ImageDownloader {
    
    func download(url: URL, toFile file: URL, completion: @escaping (URL?, Error?) -> Void) {
         URLSession.shared.downloadTask(with: url) {
            (tempURL, response, error) in
            guard let tempURL = tempURL else {
                completion(nil, error)
                return
            }
             completion(tempURL, nil)
        }.resume()
    }
}
