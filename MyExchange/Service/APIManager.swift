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
    
    func fetchData<R: Decodable>(url: URL, completion: @escaping (R?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                print(String(describing: error))
                completion(nil)
            } else {
                guard let data = data, let result = try? JSONDecoder().decode(R.self, from: data) else { completion(nil); return }
                completion(result)
            }
        }).resume()
    }
    
    
}
