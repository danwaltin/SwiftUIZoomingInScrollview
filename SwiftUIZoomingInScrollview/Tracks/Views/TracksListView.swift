//
//  TracksListView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import SwiftUI

fileprivate let tracksHeight: Double = 150

struct TracksListView: View {
    let tracks: [Track]
    @Bindable var zoom: Zoom
    
    @State private var zoomAnchorViewPortOffset: Double = 0
    @State private var isPinchZooming = false
    @State var pinchStart: Double = 0

    /// Scroll view attributes for the content
    @State private var scrollData: ScrollData = .zero
    
    /// Helper to scroll using code
    @State private var scrollToPosition: ScrollPosition = .init(edge: .top)

    @State private var initialScrollOffsetX = 0.0
    @State private var scrollOffsetX = 0.0
    
    init (tracks: [Track], zoom: Zoom) {
        self.tracks = tracks
        self.zoom = zoom
    }

    var body: some View {
        GeometryReader { g in
            let heightBelowTracks = max(0, g.size.height - (Double(tracks.count) * tracksHeight))
            
            let widthRightOfTracks = max(0, g.size.width - tracksWidth)

            
            ScrollView([.horizontal, .vertical]) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(tracks) {
                        TrackRowView(
                            track: $0,
                            height: tracksHeight,
                            zoom: zoom.value)
                    }
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(width: tracksWidth + widthRightOfTracks, height: heightBelowTracks)
                }
                .offset(x: -scrollOffsetX)
            }
            .gesture(pinchToZoom)
            .scrollPosition($scrollToPosition)
            .onChange(of: zoom.value) {
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
    }

    private func scrollData(from g: ScrollGeometry) -> ScrollData {
        .init(viewPosition: .init(x: g.contentOffset.x,
                                  y: g.contentOffset.y + g.contentInsets.top),
              viewRect: g.visibleRect)
    }

    private func zoomChanged(oldZoom: Double, newZoom: Double) {
        let zoomFactor = newZoom / oldZoom

        if isPinchZooming {
            let newScrollXPosition = zoomFactor * (scrollOffsetX + zoomAnchorViewPortOffset) - zoomAnchorViewPortOffset
            scrollOffsetX = newScrollXPosition
            return
        }
        
        // zoom from the middle of the visible part
        zoomAnchorViewPortOffset = scrollData.viewRect.size.width / 2
        
        
        let newScrollXPosition = zoomFactor * (scrollData.viewPosition.x + zoomAnchorViewPortOffset) - zoomAnchorViewPortOffset

        scrollToPosition.scrollTo(point: .init(x: newScrollXPosition, y: scrollData.viewPosition.y))
    }

    var pinchToZoom: some Gesture {
        MagnifyGesture()
            .onChanged { value in
                if pinchStart == 0 { // detect when we start a new pinch gesture
                    pinchStart = zoom.inputValue
                    isPinchZooming = true
                    zoom.isContinouslyEditing = true
                    zoomAnchorViewPortOffset = scrollData.viewPosition.x + value.startLocation.x
                }
                
                zoom.changeZoom(to: value.magnification * pinchStart)
            }
            .onEnded { _ in
                pinchStart = 0
                isPinchZooming = false
                zoom.isContinouslyEditing = false
                let newScrollX = scrollOffsetX + scrollData.viewPosition.x
                scrollOffsetX = 0
                scrollToPosition.scrollTo(point: .init(x: newScrollX, y: scrollData.viewPosition.y))
            }
    }
    
    private var tracksWidth: Double {
        tracks.reduce(0) { $0 + $1.length * zoom.value }
    }
}

struct ScrollData: Equatable {
    let viewPosition: CGPoint
    let viewRect: CGRect
    
    static var zero: ScrollData {
        .init(viewPosition: .zero, viewRect: .zero)
    }
}
