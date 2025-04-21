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

struct TrackVisualizationValue: Codable, Equatable, Hashable, Identifiable {
    let id = UUID()
    let x: Double
    let value: Double
    
    init(x: Double, value: Double) {
        self.x = x
        self.value = (value.isNaN || value.isInfinite || abs(value) > 1) ? 0.0 : value
    }
}

struct TrackVisualizationSegment: Identifiable, Equatable, Codable, Hashable {
    let id: Int
    let values: [TrackVisualizationValue]
}

extension TrackVisualizationZoomLevel: Comparable {
    static func < (lhs: TrackVisualizationZoomLevel, rhs: TrackVisualizationZoomLevel) -> Bool {
        lhs.zoomLevel < rhs.zoomLevel
    }
    
    static func == (lhs: TrackVisualizationZoomLevel, rhs: TrackVisualizationZoomLevel) -> Bool {
        lhs.zoomLevel == rhs.zoomLevel
    }
}
