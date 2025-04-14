//
//  TrackView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-14.
//

import SwiftUI

struct TrackView: View {
    let track: Track
    let height: Double
    
    var body: some View {
        HStack(spacing: 0) {
            Color.clear
                .frame(width: track.startPosition)
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                Text(track.name)
                    .padding(5)
                    
            }
            .frame(width: track.width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 6))

        }

    }
}

#Preview {
    TrackView(
        track: Track(
            id: 1,
            name: "Track 1",
            startPosition: 0,
            width: 100),
        height: 100)
    .padding(10)
}
