//
//  TrackRepository.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import Foundation
import AppKit

struct TrackRepository {
    static func getMixes() async -> [Mix] {
        return [
            await mix("1 track", trackIDs: [1]),
            await mix("2 tracks", trackIDs: [2, 3]),
            await mix("3 tracks", trackIDs: [4, 5, 6]),
            await mix("13 tracks", trackIDs: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13])
        ]
    }
    
    private static func mix(_ name: String, trackIDs: [Int]) async -> Mix {
        var tracks = [Track]()
        var position = 0.0
        for trackId in trackIDs {
            let track = await loadTrack(trackId, startPosition: position)
            tracks.append(track)
            position += track.length
        }
        
        return .init(name: name, tracks: tracks)
    }
    
    private static func loadTrack(_ id: Int, startPosition: Double) async -> Track {
        let track = tracks[id]
        let visualizations = visualizations(for: id)
        
        return .init(
            id: id,
            name: track?.name ?? "Unknown",
            startPosition: startPosition,
            length: track?.length ?? 100,
            visualizations: visualizations)
    }
    
    private static func visualizations(for trackId: Int) -> TrackVisualizations {
        var v = [Int: [TrackVisualizationValue]]()
        for level in visualizationLevels {
            if let jsonData = json(trackId: trackId, visualizationLevel: level) {
                
                if let blogPosts: [TrackVisualizationValue] = try? JSONDecoder().decode([TrackVisualizationValue].self, from: jsonData) {
                    v[level] = blogPosts
                }
            }
        }
        
        return .init(visualizations: v)
    }
    
    private static func json(trackId: Int, visualizationLevel: Int) -> Data? {
        let asset = "TrackVisualizations/\(trackId)/\(visualizationLevel)"
        if let asset = NSDataAsset(name: asset, bundle: Bundle.main) {
            return asset.data
        }
        else {
            print("Asset \(asset) not found")
        }
        
        return nil
    }
}

fileprivate let visualizationLevels = [1, 2, 4, 6, 12, 18, 25, 30, 45, 50, 70, 90]

fileprivate var tracks: [Int: (name: String, length: TimeInterval)] = [
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
