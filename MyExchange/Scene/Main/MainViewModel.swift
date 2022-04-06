//
//  MainViewModel.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 18.01.2022.
//

import Foundation

typealias ExchangeRatesCompletionBlock = (Result<ExchangeRatesResponse?, ErrorResponse>) -> ()
typealias ExchangeRatesResponseBlock = ((ErrorResponse?) -> ())

class MainViewModel {
    
    private let serviceProvider: ServiceProvider
    var exchangeRates = [Rate]()
    var baseAsset: BaseAsset = .usd
    private var exchangeRatesCompletion: ExchangeRatesResponseBlock?
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
    
    func fetchExchangeRates() {
        let url = serviceProvider.getExchangeRatesUrl(baseAsset: baseAsset)
        APIManager.shared.fetchData(url: url, completion: exchangeRatesHandler)
    }
    
    lazy var exchangeRatesHandler: ExchangeRatesCompletionBlock = { [weak self] response in
        DispatchQueue.main.async {
            switch response {
            case .success(let data):
                if let data = data {
                    self?.exchangeRates = data.rates
                }
                self?.exchangeRatesCompletion?(nil)
            case .failure(let error):
                let errorResponse = error
                self?.exchangeRatesCompletion?(errorResponse)
            }
        }
    }
    
    func subscribeExchangeRates(completion: @escaping ExchangeRatesResponseBlock) {
        exchangeRatesCompletion = completion
    }
    
}
