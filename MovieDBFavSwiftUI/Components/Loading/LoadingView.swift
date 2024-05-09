//
//  LoadingView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground.withAlphaComponent(0.8))
            ProgressView("Loading...")
                .controlSize(.large)
                .tint(.accentColor)
                .offset(.zero)
        }
        //.backgroundStyle(.gray.opacity(0.4))
    }
}

#Preview {
    LoadingView()
}
