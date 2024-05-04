//
//  MovieListView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var movieListVC = MovieListViewController()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(.themovieDBLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                HStack {
                    TextField("Search by name", text: $movieListVC.movieSearch)
                        .autocorrectionDisabled()
                        .onChange(of: movieListVC.movieSearch) {
                            if movieListVC.movieSearch.isEmpty {
                                Task {
                                    await movieListVC.loadPopularMovies()
                                }
                            }
                        }
                    Button {
                        Task {
                            await movieListVC.searchMoviesByTitle()
                        }
                    } label: {
                        Label("Search", systemImage: "magnifyingglass")
                            .tint(.mint)
                    }
                }
                .padding(20)
                
                VStack {
                    ZStack {
                        List(movieListVC.movies) { movie in
                            MovieListViewCell(movie: movie)
                                .listRowSeparator(.visible)
                        }
                        .listStyle(.inset)
                        
                        if movieListVC.isLoading {
                            LoadingView()
                        }
                        
                        if movieListVC.movies.count == 0 {
                            EmptyStateView(title: "No movies found...", imageResource: .noMovieFound, description: "Are you sure you're typing in it right?")
                        }
                    }
                    .alert(movieListVC.alertItem.title,
                           isPresented: $movieListVC.alertItem.showAlert,
                           presenting: movieListVC.alertItem,
                           actions: { alertItem in Button("OK", role: .cancel) { } },
                           message: { alertItem in alertItem.message })
                }
                Spacer()
            }
            .task {
                await movieListVC.loadPopularMovies()
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MovieListView()
}
