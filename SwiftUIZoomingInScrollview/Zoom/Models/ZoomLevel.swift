//
//  ZoomLevel.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import Foundation

import Observation

fileprivate let defaultValue = 1.0
fileprivate let defaultLowerBound = 0.1
fileprivate let defaultUpperBound = 4.0
fileprivate let defaultStep = 0.5

fileprivate let defaultZoomStrategy = LinearZoomStrategy(
    defaultInputValue: 1.0,
    inputValueRange: .init(lowerBound: 0.1, upperBound: 4.0),
    inputValueStep: 0.5)




@Observable
class ZoomLevel {
    var inputRange: ClosedRange<Double> {
        strategy.inputValueRange.lowerBound...strategy.inputValueRange.upperBound
    }

    /// The projected zoom value
    var value: Double
    
    /// The zoom value. Don't set the zoom directly using this property. Instead use the changeZoom(to:) method.
    /// However it is possible to set directly, this is so that it can be used in as a binding to a slider
    var inputValue: Double {
        didSet {
            value = strategy.projectedValue(fromRawValue: inputValue)
        }
    }
    
    /// E.g. when changing the zoom level using a slider
    /// or a pinch gesture
    var isContinouslyEditing = false

    private let originalValue: Double
    
    private let strategy: ZoomStrategy
    
    init(strategy: ZoomStrategy = defaultZoomStrategy) {
        
        let validValue = strategy.inputValueRange.clamp(value: strategy.defaultInputValue)
        self.inputValue = validValue
        self.value = strategy.projectedValue(fromRawValue: validValue)
        self.originalValue = validValue
        self.strategy = strategy
    }
    
    /// Change the input value of the zoom
    /// keeping it in the allowed range
    func changeZoom(to newValue: Double) {
        let clamped = strategy.inputValueRange.clamp(value: newValue)
        inputValue = clamped
    }
    
    func reset() {
        inputValue = originalValue
    }

    /// Increase the input value one step, keeping it in range
    func zoomIn() {
        changeZoom(to: inputValue + strategy.inputValueStep)
    }

    /// Decrease the input value one step, keeping it in range
    func zoomOut() {
        changeZoom(to: inputValue - strategy.inputValueStep)
    }
}

