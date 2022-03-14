//
//  APODWorker.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation


class APODWorker {
    func APODList(date: String,completion: @escaping serviceResponse) {
        APIManager.sharedInstance.callService(APODService(date: date), withCallback: completion)
    }
}
