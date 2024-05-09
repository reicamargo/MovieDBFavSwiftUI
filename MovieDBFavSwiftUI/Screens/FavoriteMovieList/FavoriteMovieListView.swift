//
//  FavoriteMovieListView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

struct FavoriteMovieListView: View {
    @StateObject var favoriteMovieList = FavoriteMovieListViewModel()
    //@FocusState private var moveSearchIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            
            SearchView(textSearch: $favoriteMovieList.favoriteSearch, filter: $favoriteMovieList.filter)            
            ZStack {
                VStack {
                    if favoriteMovieList.filteredFavorites.count == 0 && !favoriteMovieList.isLoading {
                        EmptyStateView(title: "No favorites yet...", imageResource: .noFavMovies, description: "Go to Movies tab and add movies to your favs!")
                    }
                    
                    List {
                        ForEach(favoriteMovieList.filteredFavorites) { favorite in
                            NavigationLink(value: favorite.id) {
                                MovieListCellView(movie: favorite)
                                    .listRowSeparator(.visible)
                            }
                        }
                        .onDelete { indexSet in
                            withAnimation {
                                favoriteMovieList.remove(attOffsets: indexSet)
                            }
                        }
                    }
                    .listStyle(.inset)
                    .navigationDestination(for: Int.self) { favoriteId in
                        // TODO: change for just passing a var id or let it this way passing a View Model?
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
            .navigationTitle("My Favorites")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FavoriteMovieListView()
}
