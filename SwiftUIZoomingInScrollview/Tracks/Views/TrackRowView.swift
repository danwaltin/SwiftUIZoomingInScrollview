//
//  TrackRowView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-21.
//

import SwiftUI

struct TrackRowView: View {
    let track: Track
    let height: Double
    let zoom: Double

    var body: some View {
        TrackView(track: track, zoom: zoom)
            .frame(height: height)

    }
}

struct TrackRowHeaderView: View {
    let trackName: String
    let height: Double
    
    var body: some View {
        Text("Track")
    }
}
