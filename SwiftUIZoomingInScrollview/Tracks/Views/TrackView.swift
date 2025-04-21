//
//  TrackView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-14.
//

import SwiftUI

struct TrackView: View {
    let track: Track
    let zoom: Double
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                trackVisualization()
                Text(track.name)
                    .padding(5)
                    
            }
            .frame(width: track.length * zoom)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
            Spacer(minLength: 0)
        }
        .offset(x: track.startPosition * zoom)
    }

    @ViewBuilder
    private func trackVisualization() -> some View {
//                        TrackVisualizationView(
//                            visualizations: track.visualizations,
//                            zoomLevel: zoomLevel,
//                            trackContentHeight: height)

        let visualizations = track.visualizations.visualizations.first(where: { $0.zoomLevel == zoomLevel })
        let values = visualizations?.values ?? []

        SwiftChartTrackVisualizationView(values: values)
    }
    
    var zoomLevel: Int {
        track
            .visualizations
            .visualizations
            .sorted()
            .first(where: {$0.zoomLevel >= Int(zoom)})?
            .zoomLevel ?? 1
    }
}

