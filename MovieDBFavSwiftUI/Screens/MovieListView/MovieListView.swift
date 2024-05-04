//
//  MovieListView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var movieList = MovieListViewModel()
    @FocusState private var moveSearchIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                LogoImageView()
                HStack {
                    TextField("Search by name", text: $movieList.movieSearch)
                        .autocorrectionDisabled()
                        .keyboardType(.default)
                        .focused($moveSearchIsFocused)
                        .onChange(of: movieList.movieSearch) {
                            if movieList.movieSearch.isEmpty {
                                moveSearchIsFocused = false
                                Task {
                                    await movieList.loadPopularMovies()
                                }
                            }
                        }
                    Button {
                        moveSearchIsFocused = false
                        Task {
                            await movieList.searchMoviesByTitle()
                        }
                    } label: {
                        Label("Search", systemImage: "magnifyingglass")
                            .tint(.accent)
                    }
                }
                .padding(20)
                
                VStack {
                    ZStack {
                        if movieList.movies.count == 0 && !movieList.isLoading {
                            EmptyStateView(title: "No movies found...", imageResource: .noMovieFound, description: "Are you sure you're typing in it right?")
                        }
                        
                        List(movieList.movies) { movie in
                            NavigationLink(value: movie.id) {
                                MovieListViewCell(movie: movie)
                                    .listRowSeparator(.visible)
                            }
                        }
                        .listStyle(.inset)
                        .navigationDestination(for: Int.self) { movieId in
                            // TODO: change for just passing a var movie.id or let it this way passing a VC?
                            MovieDetailView(movieDetail: MovieDetailViewModel(selectedMovieID: movieId))
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
                if movieList.movies.count == 0 {
                    await movieList.loadPopularMovies()
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
