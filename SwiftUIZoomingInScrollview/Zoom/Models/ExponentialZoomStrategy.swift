//
//  ExponentialZoomStrategy.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import Foundation

struct ExponentialZoomStrategy : ZoomStrategy {
	let factor: Double
	let defaultInputValue: Double
	let inputValueRange: ZoomRange
	let inputValueStep: Double
	
	func projectedValue(fromRawValue rawValue: Double) -> Double {
		exp(factor * rawValue)
	}
}
