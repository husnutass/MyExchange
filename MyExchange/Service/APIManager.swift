//
//  APIManager.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 20.01.2022.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func fetchData<R: Decodable>(url: URL, completion: @escaping (Result<R?, Error>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // Server error
                let errorResponse = ErrorResponse(errorMessage: error.localizedDescription, errorCode: error._code, errorType: .serverError)
                completion(.failure(errorResponse))
            } else {
                do {
                    guard let data = data else {
                        // No data
                        let errorResponse = ErrorResponse(errorMessage: error?.localizedDescription, errorCode: 404, errorType: .missingData)
                        completion(.failure(errorResponse))
                        return
                    }
                    let result = try JSONDecoder().decode(R.self, from: data)
                    // Success
                    completion(.success(result))
                } catch let error {
                    // Decoding error
                    let errorResponse = ErrorResponse(errorMessage: error.localizedDescription, errorCode: error._code, errorType: .decodingError)
                    completion(.failure(errorResponse))
                }
            }
        }.resume()
    }
    
}
