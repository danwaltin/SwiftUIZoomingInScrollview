//
//  ZoomControl.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import SwiftUI

struct ZoomControl: View {
    @Bindable var zoom: Zoom

    var body: some View {
        HStack {
            Button(action: {zoom.zoomOut()}) {
                Image(systemName: "minus")
            }
            .buttonStyle(.borderless)
            
            Slider(
                value: $zoom.inputValue,
                in: zoom.inputRange,
                label: {EmptyView()},
                minimumValueLabel: {EmptyView()},
                maximumValueLabel: {EmptyView()},
                onEditingChanged: {
                    zoom.isContinouslyEditing = $0
                }
            )
            
            Button(action: {zoom.zoomIn()}) {
                Image(systemName: "plus")
            }
            .buttonStyle(.borderless)

            Text("\(zoom.value, format: .number.precision(.fractionLength(1)))")
                .font(.footnote)
                .monospacedDigit()
        }
        .controlSize(.mini)
    }
}

#Preview {
    ZoomControl(zoom: Zoom())
}
