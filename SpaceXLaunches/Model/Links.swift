//
//  Links.swift
//  SpaceXLaunches
//
//  Created by Patrik Cesnek on 21/03/2025.
//

struct Links: Codable {
    let missionPatch: String?
    
    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
    }
}