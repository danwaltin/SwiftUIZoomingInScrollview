//
//  EditTracksView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import SwiftUI

struct EditTracksView: View {
    @State var zoom = Zoom(strategy: linearZoomStrategy)

    let mix: Mix
    
    var body: some View {
        VStack(spacing: 0) {
            TracksListView(
                tracks: mix.tracks,
                zoom: zoom)
            Divider()
            ZoomControl(zoom: zoom)
                .padding()
                .frame(maxWidth: 200)
        }
    }
}

#Preview {
    EditTracksView(mix: Mix(name: "Mix name", tracks: []))
}
