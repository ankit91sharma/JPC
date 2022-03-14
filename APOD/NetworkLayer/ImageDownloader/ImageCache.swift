//
//  ImageCache.swift
//  APOD
//
//  Created by Ankit Sharma on 14/03/22.
//

import Foundation
import UIKit

class ImageCache {
    
    func cachedImage(url: URL) -> UIImage? {
        if let data = try? Data(contentsOf: cachedPath(url: url).absoluteURL) {
            return data.convertDataToImage()
        }
        return nil
    }
    
    func cachedPath(url: URL) -> URL {
        let fileCachePath = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                url.lastPathComponent,
                isDirectory: false
            )
        return fileCachePath
    }
    
    func createDiskCachetoFile(file: URL, tempURL: URL) throws {
        if FileManager.default.fileExists(atPath: file.path) {
            try FileManager.default.removeItem(at: file)
        }
        try FileManager.default.copyItem(
            at: tempURL,
            to: file
        )
    }
}
