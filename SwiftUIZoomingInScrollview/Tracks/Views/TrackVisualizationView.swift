//
//  TrackVisualizationView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-17.
//

import SwiftUI

fileprivate struct VisualizationPath {
    let stroke: Path
    let fill: Path
}

extension TrackVisualizationValue {
    func asDisplayPoint(trackHeight: Double) -> CGPoint {
        .init(x: self.x, y: self.value * trackHeight)
    }

    func asBaselinePoint() -> CGPoint {
        .init(x: self.x, y: 0)
    }
}

struct TrackVisualizationView: View {
    let visualizations: TrackVisualizations
    let zoomLevel: Int
    let trackContentHeight: Double
    
    @State private var isVisible = false
    
    var body: some View {
        let path = trackVisualizationPath(values: visualizations.visualizations[zoomLevel]!)
        content()
            .onScrollVisibilityChange(threshold: 0.01) {
                isVisible = $0
            }

    }

    @ViewBuilder
    private func content() -> some View {
        if isVisible {
            let path = trackVisualizationPath(values: visualizations.visualizations[zoomLevel]!)
            TrackVisualizationGraph(path: path)
                .scaleEffect(y: -1)
        } else {
            Color.clear
        }
    }

    private func trackVisualizationPath(values: [TrackVisualizationValue]) -> VisualizationPath {
        guard let first = values.first, let last = values.last else {
            return .init(stroke: Path(), fill: Path())
        }

        let stroke = Path { path in
            path.move(to: first.asDisplayPoint(trackHeight: trackContentHeight))
            
            for value in values {
                path.addLine(to: value.asDisplayPoint(trackHeight: trackContentHeight))
            }
        }
        
        let fill = Path { path in
            path.move(to: first.asBaselinePoint())
            path.addLine(to: first.asDisplayPoint(trackHeight: trackContentHeight))
            
            for value in values {
                path.addLine(to: value.asDisplayPoint(trackHeight: trackContentHeight))
            }

            path.addLine(to: last.asBaselinePoint())
        }
        
        return .init(stroke: stroke, fill: fill)
    }
}

fileprivate struct TrackVisualizationGraph: View {
    private static let mainFillColor = Color.green
    private static let mainStrokeColor = Color.gray
    private static let mainGradient = LinearGradient(
        gradient: Gradient (
            colors: [
                mainFillColor.opacity(0.3),
                mainFillColor.opacity(0.95),
                mainFillColor.opacity(1.0),
            ]
        ),
        startPoint: .top,
        endPoint: .bottom
    )

    let path: VisualizationPath

    var body: some View {
        ZStack {
            TrackVisualizationShape(path: path.fill)
                .fill(Self.mainGradient)
            TrackVisualizationShape(path: path.stroke)
                .stroke(Self.mainStrokeColor, lineWidth: 0.5)
        }
    }
}

struct TrackVisualizationShape: Shape {
    let path: Path
    
    func path(in rect: CGRect) -> Path {
        let translation = CGAffineTransform(translationX: -path.boundingRect.minX, y: 0)

        let xScale = rect.width / path.boundingRect.width
        let scale = CGAffineTransform(scaleX: xScale, y: 1)

        return path
            .applying(translation)
            .applying(scale)
    }
}

