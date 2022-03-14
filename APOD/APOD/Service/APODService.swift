//
//  APODService.swift
//  APOD
//
//  Created by Ankit Sharma on 12/03/22.
//

import Foundation

class APODService: BaseService {

    init(date: String) {
        super.init()
        self.parser = GenericParser<APODModelResponse>()
        self.params = ["api_key": Enviroment.apiKey, "date": date]
    }
}
