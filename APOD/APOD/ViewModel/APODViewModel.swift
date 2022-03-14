//
//  APODViewModel.swift
//  APOD
//
//  Created by Ankit Sharma on 11/03/22.
//

import Foundation
import Combine
import UIKit

class APODViewModel {
    let dataRecived = PassthroughSubject<Void, Never>()
    let apiFailed = PassthroughSubject<NetworkError, Never>()
    
    private var dataSource: [APODImageTableViewCellViewModel] = [APODImageTableViewCellViewModel]()
    private var selectedDate: String = Date().dateToString()
    
    func getAPODData() {
        APODWorker().APODList(date: selectedDate) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let response):
                weakSelf.parseData(response: response, shouldCache: true)
                weakSelf.dataRecived.send()
            case .failure(let error):
                weakSelf.apiFailed.send(error)
                if let data = UserDefaults.standard.value(forKey: APODAPIConstants.userDefaultKey) as? Data {
                    if let res = try? PropertyListDecoder().decode(APODModelResponse.self, from: data) {
                        weakSelf.parseData(response: res, shouldCache: false)
                        weakSelf.dataRecived.send()
                        weakSelf.selectedDate = res.date
                    }
                }
            }
        }
    }
    
    private func parseData(response: Any, shouldCache: Bool) {
        if let res = response as? APODModelResponse {
            if shouldCache {
                UserDefaults.standard.set(try? PropertyListEncoder().encode(res), forKey: APODAPIConstants.userDefaultKey)
            }
            if dataSource.count > 0 {
                dataSource.removeAll()
            }
            dataSource.append(APODImageTableViewCellViewModel.init(model: res))
        }
    }
}

extension APODViewModel {
    func getRowsCount() -> Int {
        return dataSource.count
    }
    
    func getRowData(for row: Int) -> APODImageTableViewCellViewModel? {
        return dataSource[row]
    }
    
    func setDate(date: Date) {
        self.selectedDate = date.dateToString()
    }
    
    func getDate() -> String {
       return selectedDate
    }
}
