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
            AsyncImage(url: movie.imageURL(posterSize: .w92)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
            } placeholder: {
                Image(.moviePlaceholder)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
            }
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
