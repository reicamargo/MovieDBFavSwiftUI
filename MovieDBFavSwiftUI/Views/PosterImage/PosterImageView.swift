//
//  PosterImageView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 04/05/24.
//

import SwiftUI

struct PosterImageView: View {
    var url: URL?
    var width: CGFloat
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width)
        } placeholder: {
            Image(.moviePlaceholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width)
        }
    }
}

#Preview {
    PosterImageView(url: MockMovie.movieOne.imageURL(posterSize: .w92), width: 80)
}
