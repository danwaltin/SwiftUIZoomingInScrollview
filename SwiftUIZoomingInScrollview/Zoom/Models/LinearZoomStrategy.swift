//
//  LinearZoomStrategy.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//


import Foundation
import Observation

struct LinearZoomStrategy : ZoomStrategy {
    let defaultInputValue: Double
    let inputValueRange: ZoomRange
    let inputValueStep: Double
    private let slope: Double
    
    init(defaultInputValue: Double, inputValueRange: ZoomRange, inputValueStep: Double, slope: Double = 1) {
        self.defaultInputValue = defaultInputValue
        self.inputValueRange = inputValueRange
        self.inputValueStep = inputValueStep
        self.slope = slope
    }
    
    func projectedValue(fromRawValue rawValue: Double) -> Double {
        rawValue * slope
    }
}