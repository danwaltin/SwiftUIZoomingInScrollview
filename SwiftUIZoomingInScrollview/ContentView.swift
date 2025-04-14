//
//  ContentView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import SwiftUI


struct ContentView: View {
    @State private var isLoadingTracks = true

    @State private var trackCollections: [TrackCollection] = []
    @State private var selectedTrackCollectionID: TrackCollection.ID?
    
    var body: some View {
        content()
            .task {
                await loadTracks()
                isLoadingTracks = false
            }
    }
    
    @ViewBuilder
    func content() -> some View {
        if isLoadingTracks {
            ProgressView()
            Text("Loading tracks...")
        } else {
            NavigationSplitView {
                Sidebar(selection: $selectedTrackCollectionID, tracksCollections: trackCollections)
            } detail: {
                if let trackCollection = selectedTrackCollection {
                    EditTracksView(trackCollection: trackCollection)
                } else {
                    Text("Select a mix.")
                }
            }
            .navigationTitle(selectedTrackCollection?.name ?? "(No selection)")
        }
    }
    
    private var selectedTrackCollection : TrackCollection? {
        trackCollections.first(where: { $0.id == selectedTrackCollectionID })
    }
    
    private func loadTracks() async {
        trackCollections = await TrackRepository.getAllTracksCollections()
    }
}

#Preview {
    ContentView()
}
