//
//  ZoomStrategy.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//


import Foundation
import Observation

protocol ZoomStrategy {
    var defaultInputValue: Double { get }
    var inputValueRange: ZoomRange { get }
    var inputValueStep: Double { get }
    
    func projectedValue(fromRawValue rawValue: Double) -> Double
}