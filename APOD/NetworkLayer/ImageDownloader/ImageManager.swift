//
//  ImageManager.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation
import Combine
import UIKit

class ImageManager {
    
    func loadData(imageUrl: String, completion: @escaping (UIImage?, NetworkError?) -> Void) {
        if let url = URL(string: imageUrl) {
            if let image = ImageCache().cachedImage(url: url) {
                completion(image, nil)
            } else {
                downloadData(url: url, fileCachePath: ImageCache().cachedPath(url: url)) { image, error in
                    completion(image, error)
                }
            }
        }
    }
        
    private func downloadData(url: URL, fileCachePath: URL, completion: @escaping (UIImage?, NetworkError?) -> Void) {
        ImageDownloader().download(url: url, toFile: fileCachePath) { (temp, error) in
            if let tempURL = temp {
                if let data = try? Data(contentsOf: tempURL) {
                    do {
                        try ImageCache().createDiskCachetoFile(file: fileCachePath, tempURL: tempURL)
                    }
                    catch let error {
                        print(error.localizedDescription)
                        completion(nil, .unknown)
                    }
                    completion(data.convertDataToImage(), nil)
                }
            } else {
                completion(nil, .invalidURL)
            }
        }
    }
}



