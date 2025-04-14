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
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(tracks) { t in
                    TrackView(track: t, height: tracksHeight)
                }
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(width: tracksWidth + widthRightOfTracks, height: heightBelowTracks)
            }
        }
        .padding(0)
    }
    
    private var heightBelowTracks: Double {
        max(0, containerSize.height - (Double(tracks.count) * tracksHeight))
    }
    
    private var widthRightOfTracks: Double {
        max(0, containerSize.width - tracksWidth)
    }
    
    private var tracksWidth: Double {
        tracks.reduce(0) { $0 + $1.width }
    }
}

#Preview {
    TracksListView(tracks: [
        Track(id: 1, name: "Track 1", startPosition: 0, width: 100),
        Track(id: 2, name: "Track 2", startPosition: 100, width: 200),
    ],
                   containerSize: .init(width: 300, height: 250))
}
