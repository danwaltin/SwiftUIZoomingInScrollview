//
//  TracksListView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import SwiftUI

fileprivate let tracksHeight: Double = 100

struct TracksListView: View {
    let tracks: [Track]
    let containerSize: CGSize
    @Bindable var zoomLevel: ZoomLevel
    
    @State private var zoomAnchorViewPortOffset: Double = 0
    @State private var isPinchZooming = false
    @State var pinchStart: Double = 0

    /// Scroll view attributes for the content
    @State private var scrollData: ScrollData = .zero
    
    /// Helper to scroll using code
    @State private var scrollToPosition: ScrollPosition = .init(edge: .top)

    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(tracks) { t in
                    TrackView(
                        name: t.name,
                        startPosition: t.startPosition * zoomLevel.value,
                        width: t.length * zoomLevel.value,
                        height: tracksHeight)
                }
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(width: tracksWidth + widthRightOfTracks, height: heightBelowTracks)
            }
        }
        .gesture(pinchToZoom)
        .scrollPosition($scrollToPosition)
        .onChange(of: zoomLevel.value) {
            zoomChanged(oldZoom: $0, newZoom: $1)
        }
        .onScrollGeometryChange(for: ScrollData.self) {
            scrollData(from: $0)
        } action: { oldValue, newValue in
            if oldValue != newValue {
                scrollData = newValue
            }
        }
        .padding(0)
    }

    private func scrollData(from g: ScrollGeometry) -> ScrollData {
        .init(viewPosition: .init(x: g.contentOffset.x,
                                  y: g.contentOffset.y + g.contentInsets.top),
              viewRect: g.visibleRect,
              contentInsets: g.contentInsets)
    }

    private func zoomChanged(oldZoom: Double, newZoom: Double) {
        if !isPinchZooming {
            // zoom from the middle of the visible part
            zoomAnchorViewPortOffset = scrollData.viewRect.size.width / 2
        }
        
        let zoomFactor = newZoom / oldZoom
        
        let newScrollXPosition = zoomFactor * (scrollData.viewPosition.x + zoomAnchorViewPortOffset) - zoomAnchorViewPortOffset

        scrollToPosition.scrollTo(point: .init(x: newScrollXPosition, y: scrollData.viewPosition.y))
    }

    var pinchToZoom: some Gesture {
        MagnifyGesture()
            .onChanged { value in
                if pinchStart == 0 { // detect when we start a new pinch gesture
                    pinchStart = zoomLevel.inputValue
                    isPinchZooming = true
                    zoomLevel.isContinouslyEditing = true
                    zoomAnchorViewPortOffset = value.startLocation.x
                }
                
                zoomLevel.changeZoom(to: value.magnification * pinchStart)
            }
            .onEnded { _ in
                pinchStart = 0
                isPinchZooming = false
                zoomLevel.isContinouslyEditing = false
            }
    }

    private var heightBelowTracks: Double {
        max(0, containerSize.height - (Double(tracks.count) * tracksHeight))
    }
    
    private var widthRightOfTracks: Double {
        max(0, containerSize.width - tracksWidth)
    }
    
    private var tracksWidth: Double {
        tracks.reduce(0) { $0 + $1.length * zoomLevel.value }
    }
}

#Preview {
    TracksListView(
        tracks: [
            Track(
                id: 1,
                name: "Track 1",
                startPosition: 0,
                length: 1.min + 30.sec,
                visualizations: TrackVisualizations(visualizations: [:])),
            Track(
                id: 2,
                name: "Track 2",
                startPosition: 100,
                length: 2.min + 30.sec,
                visualizations: TrackVisualizations(visualizations: [:])),
        ],
        containerSize: .init(width: 300, height: 250),
        zoomLevel: ZoomLevel())
}

struct ScrollData: Equatable {
    let viewPosition: CGPoint
    let viewRect: CGRect
    let contentInsets: EdgeInsets
    
    static var zero: ScrollData {
        .init(viewPosition: .zero, viewRect: .zero, contentInsets: .init())
    }
}
