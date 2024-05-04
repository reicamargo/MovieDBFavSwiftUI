//
//  FavoriteMovieListView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

struct FavoriteMovieListView: View {
    @StateObject var favoriteMovieList = FavoriteMovieListViewModel()
    
    var body: some View {
        NavigationStack {
            LogoImageView()
            ZStack {
                VStack {
                    if favoriteMovieList.favorites.count == 0 && !favoriteMovieList.isLoading {
                        EmptyStateView(title: "No favorites yet...", imageResource: .noFavMovies, description: "Go to Movies tab and add movies to your favs!")
                    }
                    
                    List(favoriteMovieList.favorites) { favorite in
                        NavigationLink(value: favorite.id) {
                            MovieListViewCell(movie: favorite)
                                .listRowSeparator(.visible)
                        }
                    }
                    .listStyle(.inset)
                    .navigationDestination(for: Int.self) { favoriteId in
                        // TODO: change for just passing a var movie.id or let it this way passing a VC?
                        MovieDetailView(movieDetail: MovieDetailViewModel(selectedMovieID: favoriteId))
                    }
                    
                    if favoriteMovieList.isLoading {
                        LoadingView()
                    }
                }
                .task {
                    favoriteMovieList.loadFavorites()
                }
                .alert(favoriteMovieList.alertItem.title,
                       isPresented: $favoriteMovieList.alertItem.showAlert,
                       presenting: favoriteMovieList.alertItem,
                       actions: { alertItem in Button("OK", role: .cancel) { } },
                       message: { alertItem in alertItem.message })
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FavoriteMovieListView()
}
