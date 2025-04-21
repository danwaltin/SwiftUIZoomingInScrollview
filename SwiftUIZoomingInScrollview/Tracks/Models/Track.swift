//
//  Track.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import Foundation

struct Track: Identifiable {
    let id: Int
    let name: String
    var startPosition: Double = 0
    let length: TimeInterval
    
    let visualizations: TrackVisualizations
}
