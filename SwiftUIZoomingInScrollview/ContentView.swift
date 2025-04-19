//
//  ContentView.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import SwiftUI


struct ContentView: View {
    @State private var isLoadingTracks = true

    @State private var mixes: [Mix] = []
    @State private var selectedMixID: Mix.ID?
    
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
                Sidebar(selection: $selectedMixID, mixes: mixes)
            } detail: {
                if let mix = selectedMix {
                    EditTracksView(mix: mix)
                } else {
                    Text("Select a mix.")
                }
            }
            .navigationTitle(selectedMix?.name ?? "(No selection)")
        }
    }
    
    private var selectedMix : Mix? {
        mixes.first(where: { $0.id == selectedMixID })
    }
    
    private func loadTracks() async {
        mixes = await TrackRepository().getMixes()
    }
}

#Preview {
    ContentView()
}
