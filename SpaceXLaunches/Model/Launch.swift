//
//  Launch.swift
//  SpaceXLaunches
//
//  Created by Patrik Cesnek on 21/03/2025.
//

import Foundation

struct Launch: Codable {
    let missionName: String
    let launchDate: Date
    let rocket: Rocket
    let details: String?
    let links: Links
    
    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case launchDate = "launch_date_utc"
        case rocket, details, links
    }
}