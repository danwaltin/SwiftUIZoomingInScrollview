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
    let headerWidth: Double
    let headerOffset: Double
    
    var body: some View {
        HStack(spacing: 0) {
            Text(track.name)
                .frame(width: headerWidth, height: height)
                .border(Color.blue)
                .offset(x: headerOffset)
            TrackView(track: track, zoom: zoom)
                .frame(height: height)
        }

    }
}

struct TrackRowHeaderView: View {
    let trackName: String
    let height: Double
    
    var body: some View {
        Text("Track")
    }
}
