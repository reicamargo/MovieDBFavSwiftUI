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
                TextField("Search by name", text: $movieListVC.movieSearch)
                    .padding(.top, 20)
                    .padding(.leading, 20)
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
