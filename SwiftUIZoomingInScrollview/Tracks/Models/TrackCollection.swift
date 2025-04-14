//
//  TrackCollection.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//


import SwiftUI

struct TrackCollection: Identifiable {
    let id: UUID = UUID()
    let name: String
    let tracks: [Track]
}
