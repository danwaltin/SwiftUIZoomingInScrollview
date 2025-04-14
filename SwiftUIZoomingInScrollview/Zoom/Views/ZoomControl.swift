//
//  ZoomControl.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import SwiftUI

struct ZoomControl: View {
    @Bindable var zoomLevel: ZoomLevel

    var body: some View {
        HStack {
            Button(action: {zoomLevel.zoomOut()}) {
                Image(systemName: "minus")
            }
            .buttonStyle(.borderless)
            
            Slider(
                value: $zoomLevel.inputValue,
                in: zoomLevel.inputRange,
                label: {EmptyView()},
                minimumValueLabel: {EmptyView()},
                maximumValueLabel: {EmptyView()},
                onEditingChanged: {
                    zoomLevel.isContinouslyEditing = $0
                }
            )
            
            Button(action: {zoomLevel.zoomIn()}) {
                Image(systemName: "plus")
            }
            .buttonStyle(.borderless)

            Text("\(zoomLevel.value, format: .number.precision(.fractionLength(1)))")
                .font(.footnote)
                .monospacedDigit()
        }
        .controlSize(.mini)
    }
}

#Preview {
    ZoomControl(zoomLevel: ZoomLevel())
}
