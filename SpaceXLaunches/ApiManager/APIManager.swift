//
//  APIManager.swift
//  SpaceXLaunches
//
//  Created by Patrik Cesnek on 21/03/2025.
//

import UIKit

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func fetchLaunches(completion: @escaping (Result<[Launch], Error>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v3/launches/past") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode([Launch].self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}