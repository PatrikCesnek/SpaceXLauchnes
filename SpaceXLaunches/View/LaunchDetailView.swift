//
//  LaunchDetailView.swift
//  SpaceXLaunches
//
//  Created by Patrik Cesnek on 21/03/2025.
//

import SwiftUI

struct LaunchDetailView: View {
    let launch: Launch
    
    var body: some View {
        VStack {
            Text(launch.missionName)
                .font(.title)
                .bold()
            
            if let patchURL = launch.links.missionPatch, let url = URL(string: patchURL) {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text(Constants.Strings.rocket + launch.rocket.rocketName)
                Text(Constants.Strings.launchDate + launch.launchDate)
                
                if let details = launch.details {
                    Text(details)
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                }
            }
            .padding(16)
            .font(.callout)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    LaunchDetailView(
        launch: Launch(
            missionName: "MissionName",
            launchDate: "1.1.2021",
            rocket: Rocket(rocketName: "Rocket name"),
            details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            links: Links(missionPatch: nil)
        )
    )
}
