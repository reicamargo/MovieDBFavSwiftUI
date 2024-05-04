//
//  NoMoviesFound.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 04/05/24.
//

import SwiftUI

struct NoMoviesFound: View {
    var title: String = "No movies found..."
    var imageResource: ImageResource = .noMovieFound
    var description: String = "Are you sure you're typing in it right?"
    var body: some View {
        VStack {
            Image(imageResource)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding()
            Text(title)
                .font(.title2)
                .foregroundStyle(.mint)
                .padding()
            Text(description)
                .foregroundStyle(.primary)
                .font(.subheadline)
            
        }
    }
}

#Preview {
    NoMoviesFound()
}
