//
//  EditTracksView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import SwiftUI

struct EditTracksView: View {
    var zoomLevel = ZoomLevel(strategy: exponentialZoomStrategy)

    let trackCollection: TrackCollection
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { g in
                TracksListView(tracks: trackCollection.tracks, containerSize: g.size)
            }
            Divider()
            ZoomControl(zoomLevel: zoomLevel)
                .padding()
        }
    }
}

#Preview {
    EditTracksView(trackCollection: TrackCollection(name: "Collection name", tracks: []))
}
