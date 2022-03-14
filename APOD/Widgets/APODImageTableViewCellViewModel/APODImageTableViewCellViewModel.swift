//
//  APODImageTableViewCellViewModel.swift
//  APOD
//
//  Created by Ankit Sharma on 11/03/22.
//

import Foundation
import UIKit
import Combine


class APODImageTableViewCellViewModel {
    private var cancelable = Set<AnyCancellable>()
    private let model: APODModelResponse?
    let imagePublisher = PassthroughSubject<UIImage, Never>()
    
     var date: String {
        return model?.date ?? "\(NSDate())"
     }
    
    var title: String {
        return model?.title ?? ""
    }
    
    var descprition: String {
        return model?.explanation ?? ""
    }
    
    var mediaType: MediaType {
        return model?.mediaType ?? .image
    }
    
    var imageUrl: String {
        return model?.url ?? ""
    }
    
    init(model: APODModelResponse) {
        self.model = model
    }
    
    func downloadImage() {
        if let url = model?.url {
            ImageManager().loadData(imageUrl: url) { [weak self] data, error in
                guard let self = self else { return }
                if let img = data {
                    self.imagePublisher.send(img)
                }
            }
        }
    }
}
