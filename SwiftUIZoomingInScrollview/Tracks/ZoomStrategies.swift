//
//  ZoomStrategies.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import Foundation

fileprivate let linearSlope = 0.5

let linearZoomStrategy = LinearZoomStrategy(
    defaultInputValue: 1 / linearSlope,
    inputValueRange: ZoomRange(
        lowerBound: 0.5 / linearSlope,
        upperBound: 90 / linearSlope),
    inputValueStep: 0.5,
    slope: linearSlope)

let exponentialZoomStrategy = ExponentialZoomStrategy(
    factor: 0.25,
    defaultInputValue: 0, // 0 is 1, no zoom
    inputValueRange: ZoomRange(
        lowerBound: 0, // -2.8 would mean zoom 0.5
        upperBound: 17.8),
    inputValueStep: 0.3)
