//
//  Sidebar.swift
//  SwiftUIZoomingInScrollview
//
//  Created by Dan Waltin on 2025-04-13.
//

import SwiftUI

struct Sidebar: View {
    @Binding var selection: Mix.ID?
    
    let mixes: [Mix]
    
    var body: some View {
        List(mixes, selection: $selection) { mix in
            Text(mix.name)
        }
    }
}

#Preview {
    Sidebar(selection: .constant(nil), mixes: [])
}
