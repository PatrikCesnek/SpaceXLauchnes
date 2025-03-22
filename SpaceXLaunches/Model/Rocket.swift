//
//  Rocket.swift
//  SpaceXLaunches
//
//  Created by Patrik Cesnek on 21/03/2025.
//

struct Rocket: Codable {
    let rocketName: String
    
    enum CodingKeys: String, CodingKey {
        case rocketName = "rocket_name"
    }
}