//
//  TrackRepository.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import Foundation

struct TrackRepository {
    static func getAllTracksCollections() async -> [TrackCollection] {
        let track11: Track = .init(id: 11, name: "Track 1.1", startPosition: 0, width: 150)
        
        let track21: Track = .init(id: 21, name: "Track 2.1", startPosition: 0, width: 250)
        let track22: Track = .init(id: 22, name: "Track 2.2", startPosition: 250, width: 300)

        let track31: Track = .init(id: 31, name: "Track 3.1", startPosition: 0, width: 100)
        let track32: Track = .init(id: 32, name: "Track 3.2", startPosition: 100, width: 250)
        let track33: Track = .init(id: 33, name: "Track 3.3", startPosition: 350, width: 200)

        return [
            .init(name: "1 track", tracks: [
                track11
            ]),
            .init(name: "2 tracks", tracks: [
                track21,
                track22
            ]),
            .init(name: "3 tracks", tracks: [
                track31,
                track32,
                track33
            ])
        ]
    }
}

