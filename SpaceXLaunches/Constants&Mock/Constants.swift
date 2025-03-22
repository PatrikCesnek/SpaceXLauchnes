//
//  Constants.swift
//  SpaceXLaunches
//
//  Created by Patrik Cesnek on 21/03/2025.
//

struct Constants {
    static let cellReuseIdentifier = "cell"
    static let launchesURLString = "https://api.spacexdata.com/v3/launches"
    static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let localeIdentifier = "en_US_POSIX"
    
    struct Strings {
        static let rocket = "Rocket: ".localizedCapitalized
        static let launchDate = "Launch date: ".localizedCapitalized
        static let appTitle = "SpaceX Launches".localizedCapitalized
        static let searchBarPlaceholder = "Search by Mission Name".localizedCapitalized
        static let sort = "Sort".localizedCapitalized
        static let sortBy = "Sort by: ".localizedCapitalized
        static let cancel = "Cancel".localizedCapitalized
        static let dateAscending = "Date Ascending".localizedCapitalized
        static let dateDescending = "Date Descending".localizedCapitalized
        static let missionName = "Mission Name".localizedCapitalized
        static let errorMessage = "Failed to fetch launches. Please try again.".localizedCapitalized
        static let errorTitle = "Error".localizedCapitalized
        static let retry = "Retry".localizedCapitalized
        static let invalidURLMessage = "Invalid URL".localizedCapitalized
        static let noDataMessage = "No data received".localizedCapitalized
        static let invalidDateFormatMessage = "Invalid date format:".localizedCapitalized
    }
}
