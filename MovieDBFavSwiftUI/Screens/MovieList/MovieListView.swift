//
//  MovieListView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var movieList = MovieListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                LogoImageView()
                SearchView(textSearch: $movieList.movieSearch, filter: $movieList.filter)
                
                VStack {
                    ZStack {
                        if movieList.searchedMovies.count == 0 && !movieList.isLoading {
                            EmptyStateView(title: "No movies found...", imageResource: .noMovieFound, description: "Are you sure you're typing in it right?")
                        }
                        
                        ScrollViewReader { proxy in
                            
                            List {
                                ForEach(movieList.searchedMovies) { movie in
                                    NavigationLink(value: movie.id) {
                                        MovieListCellView(movie: movie)
                                            .listRowSeparator(.visible)
                                            
                                    }
                                    .id(movie.id)
                                }
                            }
                            .onChange(of: movieList.filter) {
                                withAnimation(.spring()) {
                                    proxy.scrollTo(movieList.searchedMovies.first?.id, anchor: .center)
                                }
                            }
                            .listStyle(.inset)
                            .navigationDestination(for: Int.self) { movieId in
                                // TODO: change for just passing a var movie.id or let it this way passing a View Model?
                                MovieDetailView(movieDetail: MovieDetailViewModel(selectedMovieID: movieId))
                            }
                        }
                        
                        if movieList.isLoading {
                            LoadingView()
                        }
                        
                        
                    }
                    .alert(movieList.alertItem.title,
                           isPresented: $movieList.alertItem.showAlert,
                           presenting: movieList.alertItem,
                           actions: { alertItem in Button("OK", role: .cancel) { } },
                           message: { alertItem in alertItem.message })
                }
                Spacer()
            }
            .task {
                if movieList.searchedMovies.count == 0 {
                    await movieList.loadMovies(filter: movieList.filter)
                }
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MovieListView()
}
