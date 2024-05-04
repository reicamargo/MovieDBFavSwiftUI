//
//  MovieListViewCell.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

struct MovieListViewCell: View {
    var movie: Movie
    
    var body: some View {
        HStack {
            PosterImageView(url: movie.imageURL(posterSize: .w92), width: 80)
            .padding(10)
            VStack(alignment: .leading) {
                Text(movie.title)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .font(.title2)
                    .foregroundColor(.primary)
                Text(movie.releaseDate.convertToDisplayFormat())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

#Preview {
    MovieListViewCell(movie: MockMovie.movieTwo)
}
