//
//  Utils.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-19.
//

import OSLog

func createLogger(category: String) -> Logger {
    Logger(subsystem: "SwiftUIZoomingInScrollview", category: category)
}

fileprivate let logTimeLogger = createLogger(category: "logTime")

func logTime<T>(_ name: String, action: () async -> T) async -> T{
    let start = DispatchTime.now()
    
    let result = await action()
    
    let end = DispatchTime.now()
    
    let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
    let timeInterval = Double(nanoTime) / 1_000_000_000

    logTimeLogger.info("\(name) took \(timeInterval) seconds")

    return result
}
