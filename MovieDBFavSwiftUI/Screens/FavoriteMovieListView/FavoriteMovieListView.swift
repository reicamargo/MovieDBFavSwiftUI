//
//  FavoriteMovieListView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

struct FavoriteMovieListView: View {
    var body: some View {
        NavigationStack {
            Text("Favorite list")
                .navigationTitle("Favorites")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FavoriteMovieListView()
}
