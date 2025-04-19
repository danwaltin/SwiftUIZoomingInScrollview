//
//  TrackVisualizations.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-16.
//

import Foundation

struct TrackVisualizations {
    let visualizations: [TrackVisualizationZoomLevel]
}

struct TrackVisualizationZoomLevel {
    let zoomLevel: Int
    let values: [TrackVisualizationValue]
}

struct TrackVisualizationValue: Decodable {
    let x: Double
    let value: Double
}

extension TrackVisualizationZoomLevel: Comparable {
    static func < (lhs: TrackVisualizationZoomLevel, rhs: TrackVisualizationZoomLevel) -> Bool {
        lhs.zoomLevel < rhs.zoomLevel
    }
    
    static func == (lhs: TrackVisualizationZoomLevel, rhs: TrackVisualizationZoomLevel) -> Bool {
        lhs.zoomLevel == rhs.zoomLevel
    }
}
