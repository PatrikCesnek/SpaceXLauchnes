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
            
            Text("Rocket: \(launch.rocket.rocketName)")
            Text("Launch Date: \(launch.launchDate)")
            
            if let details = launch.details {
                Text(details)
                    .padding()
            }
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
            rocket: Rocket(rocketName: "Rocket"),
            details: nil,
            links: Links(missionPatch: nil)
        )
    )
}
