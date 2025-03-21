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
            if let patchURL = launch.links.missionPatch, let url = URL(string: patchURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
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
        .navigationTitle(launch.missionName)
    }
}

#Preview {
    LaunchDetailView(
        launch: Mock.mockLaunch
    )
}
