//
//  MainViewModel.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 18.01.2022.
//

import Foundation


class MainViewModel {
    
    private let serviceProvider: ServiceProvider
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchExchangeRates(with baseAsset: BaseAsset, completion: @escaping (ExchangeRatesResponse?) -> ()) {
        let url = serviceProvider.getExchangeRatesUrl(baseAsset: baseAsset)
        APIManager.shared.fetchData(url: url, completion: completion)
    }
    
}
