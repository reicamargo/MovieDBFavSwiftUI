//
//  ContentView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

struct MovieDBTabView: View {
    var body: some View {
        TabView {
            MovieListView()
                .tabItem { Label("Movies", systemImage: "movieclapper") }
            FavoriteMovieListView()
                .tabItem { Label("Favorites", systemImage: "star") }
        }
    }
}

#Preview {
    MovieDBTabView()
}
