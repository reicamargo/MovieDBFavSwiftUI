//
//  MovieDetailView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var movieDetail: MovieDetailViewModel
    
    var body: some View {
        ZStack {
            VStack {
                PosterImageView(url: movieDetail.movie?.imageURL(posterSize: .original), width: 200)
                    .padding(.top, 30)
                Label(String(format: "%.2f / 10", movieDetail.movie?.voteAverage ?? 0.00), systemImage: "heart.fill")
                    .symbolRenderingMode(.multicolor)
                    .font(.body)
                    .foregroundStyle(.primary)
                VStack(alignment: .leading) {
                    Text("\(movieDetail.movie?.overview ?? "")")
                        .font(.body)
                        .foregroundStyle(.primary)
                        .padding(.bottom, 10)
                    Text("Genres: \(movieDetail.displayGenre())")
                        .font(.body)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                }
                .padding(20)
                Button {
                    movieDetail.isFavorite.toggle()
                } label: {
                    FavoriteButton(favorite: movieDetail.isFavorite)
                }
                
            }
            
            if movieDetail.movie == nil && !movieDetail.isLoading {
                EmptyStateView(title: "No movie found...", imageResource: .noMovieFound, description: "Something is really wrong 😫")
            }
            
            if movieDetail.isLoading {
                LoadingView()
            }
        }
        .alert(movieDetail.alertItem.title,
               isPresented: $movieDetail.alertItem.showAlert,
               presenting: movieDetail.alertItem,
               actions: { alertItem in Button("OK", role: .cancel) { } },
               message: { alertItem in alertItem.message })
        .task {
            await movieDetail.getMovie()
        }
        .navigationTitle("\(movieDetail.movie?.title ?? "")")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MovieDetailView(movieDetail: MovieDetailViewModel(selectedMovieID: 693134))
}


//godzilla -> 823464
//dune -> 693134
