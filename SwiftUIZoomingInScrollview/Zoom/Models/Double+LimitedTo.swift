//
//  Double+LimitedTo.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//


import Foundation
import Observation

extension Double {
    public func limitedTo(min: Double = 0, max: Double) -> Double {
        if self < min {
            return min
        }
        
        if self > max {
            return max
        }
        
        return self
    }
}
