//
//  TrackView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-14.
//

import SwiftUI

struct TrackView: View {
    let track: Track
    let height: Double
    let zoom: Double
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                TrackVisualizationView(
                    visualizations: track.visualizations,
                    zoomLevel: zoomLevel,
                    trackContentHeight: height)
                Text(track.name)
                    .padding(5)
                    
            }
            .frame(width: track.length * zoom, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
            Spacer(minLength: 0)
        }
        .offset(x: track.startPosition * zoom)
    }
    
    var zoomLevel: Int {
        track.visualizations.visualizations.keys.sorted().first(where: {$0 >= Int(zoom)}) ?? 1
    }
}

