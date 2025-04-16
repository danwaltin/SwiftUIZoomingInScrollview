//
//  TrackView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-14.
//

import SwiftUI

struct TrackView: View {
    let name: String
    let startPosition: Double
    let width: Double
    let height: Double
    
    var body: some View {
        HStack(spacing: 0) {
            Color.clear
                .frame(width: startPosition)
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                Text(name)
                    .padding(5)
                    
            }
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
}

#Preview {
    TrackView(
        name: "Track 1",
        startPosition: 0,
        width: 100,
        height: 100)
    .padding(10)
}
