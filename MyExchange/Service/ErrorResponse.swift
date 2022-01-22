//
//  ErrorResponse.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 23.01.2022.
//

import Foundation

struct ErrorResponse: Error {
    
    let errorMessage: String?
    let errorCode: Int?
    let errorType: ErrorType
    
}
