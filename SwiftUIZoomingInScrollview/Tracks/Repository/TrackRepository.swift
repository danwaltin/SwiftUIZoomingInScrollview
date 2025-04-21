//
//  TrackRepository.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import Foundation
import AppKit

struct TrackRepository {
    func getMixes() async -> [Mix] {
        let tracks = await loadTracksParallel([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13])
        
        return [
            mix(withTracks:[1], allTracks: tracks),
            mix(withTracks:[2, 3], allTracks: tracks),
            mix(withTracks:[4, 5, 6], allTracks: tracks),
            mix(withTracks:[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], allTracks: tracks)
        ]
    }
    
    private func mix(withTracks trackIds: [Int], allTracks: [Track]) -> Mix {
        var tracks = [Track]()
            
        var position = 0.0
        for trackId in trackIds {
            if var track = allTracks.first(where: { $0.id == trackId }) {
                track.startPosition = position
                tracks.append(track)
                position += track.length
            }
        }

        let name = tracks.count != 1 ? "\(tracks.count) tracks" : "1 track"
        return .init(name: name, tracks: tracks)
    }
    
    private func loadTracksParallel(_ trackIDs: [Int]) async -> [Track] {
        await withTaskGroup(of: (trackId: Int, visualizations: TrackVisualizations).self) { group in
            for trackId in trackIDs {
                group.addTask {
                    let v = await visualizations(for: trackId)
                    return (trackId, v)
                }
            }
            
            var tracks = [Track]()
            for await visualizations in group {
                let track = track(witId: visualizations.trackId, visualizations: visualizations.visualizations)
                tracks.append(track)
            }
            return tracks
        }
    }

    private func track(witId id: Int,visualizations: TrackVisualizations) -> Track {
        let track = tracksDatabase[id]
        
        return .init(
            id: id,
            name: track?.name ?? "Unknown",
            length: track?.length ?? 100,
            visualizations: visualizations)
    }
    
    private func visualizations(for trackId: Int) async -> TrackVisualizations {
        var v = [TrackVisualizationZoomLevel]()
        for level in visualizationLevels {
            if let values = values(trackId: trackId, visualizationLevel: level) {
                v.append(.init(zoomLevel: level, values: values))
            }
        }
        
        return .init(visualizations: v)
    }
    
    private func values(trackId: Int, visualizationLevel: Int) -> [TrackVisualizationValue]? {
        let asset = "TrackVisualizations/\(trackId)/\(visualizationLevel)"
        if let asset = NSDataAsset(name: asset, bundle: Bundle.main) {
            return try? JSONDecoder().decode([TrackVisualizationValue].self, from: asset.data)
        }

        print("Asset \(asset) not found")
        return nil
    }
}

fileprivate let visualizationLevels = [1, 2, 4, 6, 12, 18, 25, 30, 45, 50, 70, 90]

fileprivate var tracksDatabase: [Int: (name: String, length: TimeInterval)] = [
    1: ("Always Look On the Bright Side of Life",  2.min +  8.sec),
    2: ("Blinn Ulof",                              4.min +  4.sec),
    3: ("Bjekkergauken",                           2.min + 34.sec),
    4: ("Boom Boom Ba",                            3.min + 42.sec),
    5: ("Dancing Queen",                           2.min + 16.sec),
    6: ("Go West",                                 4.min + 11.sec),
    7: ("Happyland",                               3.min + 22.sec),
    8: ("How Much Is the Fish?",                   3.min + 46.sec),
    9: ("Julen Är Här",                            3.min + 16.sec),
    10: ("Längtan till landet (Vintern rasat ut)", 1.min + 42.sec),
    11: ("Minor Swing",                            2.min +  6.sec),
    12: ("Söndermarken",                           5.min + 59.sec),
    13: ("Porcelain (Luca Agnelli Remix)",         7.min + 52.sec)
]

extension Int {
    var min: TimeInterval {
        get {
            return TimeInterval(60 * self)
        }
    }
    
    var sec: TimeInterval {
        get {
            return TimeInterval(self)
        }
    }
}
