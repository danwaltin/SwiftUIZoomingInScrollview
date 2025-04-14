//
//  Sidebar.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import SwiftUI

struct Sidebar: View {
    @Binding var selection: TrackCollection.ID?
    
    let tracksCollections: [TrackCollection]
    
    var body: some View {
        List(tracksCollections, selection: $selection) { collection in
            Text(collection.name)
        }
    }
}

#Preview {
    Sidebar(selection: .constant(nil), tracksCollections: [])
}
