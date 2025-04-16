//
//  TrackVisualizations.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-16.
//

import Foundation

struct TrackVisualizations {
    let visualizations: [Int:[TrackVisualizationValue]]
}

struct TrackVisualizationValue: Decodable {
    let x: Double
    let value: Double
}
