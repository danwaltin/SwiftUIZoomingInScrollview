//
//  SwiftChartTrackVisualizationView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-20.
//


import SwiftUI
import Charts

fileprivate let mainFillColor = Color.green.opacity(0.5)
fileprivate let mainStrokeColor = Color.gray

struct SwiftChartTrackVisualizationView: View {
    let values: [TrackVisualizationValue]
    
    var body: some View {
        SegmentView(values: values)
    }
}

fileprivate struct SegmentView: View {
    let values: [TrackVisualizationValue]
    
    @State private var isVisible = true
    
    var body: some View {
        content
            .onScrollVisibilityChange(threshold: 0.01) {
                isVisible = $0
            }
    }
    
    @ViewBuilder
    var content: some View {
        if isVisible {
            VStack(spacing: 0) {
                Spacer()
                Chart {
                    
                    AreaPlot(
                        values,
                        x: .value("x", \.x),
                        y: .value("y", \.value))
                    .foregroundStyle(mainFillColor)

                    LinePlot(
                        values,
                        x: .value("x", \.x),
                        y: .value("y", \.value))
                    .lineStyle(.init(lineWidth: 0.5))
                    .foregroundStyle(mainStrokeColor)
                }
                .chartYScale(domain: [0, 1])
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
            }
            
        } else {
            Color.clear
        }
    }
}
