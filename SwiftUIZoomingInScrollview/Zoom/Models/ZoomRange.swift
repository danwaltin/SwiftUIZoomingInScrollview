//
//  ZoomRange.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//


import Foundation
import Observation

struct ZoomRange: Equatable {
    let lowerBound: Double
    let upperBound: Double
    
    init(lowerBound: Double, upperBound: Double) {
        assert(lowerBound < upperBound)
        
        self.lowerBound = lowerBound
        self.upperBound = upperBound
    }
    func clamp(value: Double) -> Double {
        value.limitedTo(min: lowerBound, max: upperBound)
    }
}