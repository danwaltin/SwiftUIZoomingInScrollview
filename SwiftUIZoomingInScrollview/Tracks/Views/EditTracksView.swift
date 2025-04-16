//
//  EditTracksView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import SwiftUI

struct EditTracksView: View {
    var zoomLevel = ZoomLevel(strategy: linearZoomStrategy)

    let mix: Mix
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { g in
                TracksListView(
                    tracks: mix.tracks,
                    containerSize: g.size,
                    zoomLevel: zoomLevel)
            }
            Divider()
            ZoomControl(zoomLevel: zoomLevel)
                .padding()
                .frame(maxWidth: 200)
        }
    }
}

#Preview {
    EditTracksView(mix: Mix(name: "Mix name", tracks: []))
}
