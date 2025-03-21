//
//  LaunchesViewModel.swift
//  SpaceXLaunches
//
//  Created by Patrik Cesnek on 21/03/2025.
//

import UIKit

class LaunchesViewModel: NSObject {
    private var launches: [Launch] = []
    var filteredLaunches: [Launch] = []
    var sortingOption: SortingOption = .dateDescending
    
    enum SortingOption: String, CaseIterable {
        case dateAscending = "Date Ascending"
        case dateDescending = "Date Descending"
        case missionName = "Mission Name"
    }
    
    func fetchLaunches(completion: @escaping () -> Void) {
        APIManager.shared.fetchLaunches { result in
            switch result {
            case .success(let launches):
                self.launches = launches
                self.applySorting()
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let error):
                print("Error fetching launches: \(error)")
            }
        }
    }
    
    func applySorting() {
        switch sortingOption {
        case .dateAscending:
            filteredLaunches = launches.sorted { $0.launchDate < $1.launchDate }
        case .dateDescending:
            filteredLaunches = launches.sorted { $0.launchDate > $1.launchDate }
        case .missionName:
            filteredLaunches = launches.sorted { $0.missionName < $1.missionName }
        }
    }
    
    func searchLaunches(query: String) {
        if query.isEmpty {
            applySorting()
        } else {
            filteredLaunches = launches.filter { $0.missionName.lowercased().contains(query.lowercased()) }
        }
    }
}
