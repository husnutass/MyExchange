//
//  ServiceProvider.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 20.01.2022.
//

import Foundation

typealias URLResponseCompletionBlock = (Data?, URLResponse?, Error?) -> Void

class ServiceProvider {
    
    private let baseUrl = "https://rest-sandbox.coinapi.io/v1/"
    private let apiKey = "?apikey=5A4C9C93-205F-43C8-993C-110445767B55"
    
    func getExchangeRatesUrl(baseAsset: BaseAsset) -> URL {
        return URL(string: baseUrl + EndPoint.rates.rawValue + baseAsset.rawValue + apiKey)!
    }
    
}

enum EndPoint: String {
    case rates = "exchangerate/"
}

enum BaseAsset: String, CaseIterable {
    case usd = "USD"
    case btc = "BTC"
}
