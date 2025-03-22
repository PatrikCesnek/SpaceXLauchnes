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
        guard let url = URL(string: Constants.launchesURLString) else {
            completion(.failure(NSError(domain: Constants.Strings.invalidURLMessage, code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: Constants.Strings.noDataMessage, code: 0)))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom { decoder -> Date in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                
                let formatter = DateFormatter()
                formatter.dateFormat = Constants.dateFormat
                formatter.locale = Locale(identifier: Constants.localeIdentifier)
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                
                if let date = formatter.date(from: dateString) {
                    return date
                } else {
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "\(Constants.Strings.invalidDateFormatMessage) \(dateString)")
                }
            }
            
            do {
                let decodedData = try decoder.decode([Launch].self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}