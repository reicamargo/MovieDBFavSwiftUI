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
            EmptyStateView(title: "No favorites yet...", imageResource: .noFavMovies, description: "Go to Movies tab and add movies to your favs!")
                .navigationTitle("Favorites")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FavoriteMovieListView()
}
