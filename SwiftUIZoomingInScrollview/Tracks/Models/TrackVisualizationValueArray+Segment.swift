//
//  TrackVisualizationValueArray+Segment.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-19.
//


extension Array where Element == TrackVisualizationValue {
	func segment(numberOfSegments: Int) -> [TrackVisualizationSegment] {
		if self.count == 0  || numberOfSegments == 0 {
			return []
		}

		if self.count == 1 || numberOfSegments == 1{
			return [.init(id: 0, values: self)]
		}

		var segments: [TrackVisualizationSegment] = []
		
		let strideBy = self.count / numberOfSegments

		if strideBy == 0 {
			return [.init(id: 0, values: self)]
		}
		
		for i in stride(from: 0, to: self.count, by: strideBy) {
			let upperIndex = Swift.min(i + strideBy, self.count)
			let values = Array(self[i..<upperIndex])
			let translatedValues = values.map {
				TrackVisualizationValue(x: $0.x, value: $0.value)
			}
			segments.append(.init(id: 0, values: translatedValues))
		}

		// add the first sample from each "next" segment, to avoid gaps in the visualization
		var adjustedSegments: [TrackVisualizationSegment] = []
		var segmentId = 0
		for i in 1..<segments.count {
			var previousSegmentValues = segments[i-1].values
			if let thisSegmentFirstValue = segments[i].values.first {
				previousSegmentValues.append(.init(
					x: thisSegmentFirstValue.x,
					value: thisSegmentFirstValue.value))
			}
			
			adjustedSegments.append(.init(id: segmentId, values: previousSegmentValues))
			segmentId += 1
		}

		adjustedSegments.append(.init(id: segmentId, values: segments.last?.values ?? []))
		
		return adjustedSegments
	}
}

