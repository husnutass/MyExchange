//
//  ExchangeRates.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 20.01.2022.
//

import Foundation

// MARK: - ExchangeRatesResponse
struct ExchangeRatesResponse: Codable {
    let assetIDBase: String
    let rates: [Rate]

    enum CodingKeys: String, CodingKey {
        case assetIDBase = "asset_id_base"
        case rates
    }
}

// MARK: - Rate
struct Rate: Codable {
    let time, assetIDQuote: String
    let rate: Double

    enum CodingKeys: String, CodingKey {
        case time
        case assetIDQuote = "asset_id_quote"
        case rate
    }
}
