//
//  NoFavoriteView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

struct EmptyStateView: View {
    var title: String
    var imageResource: ImageResource
    var description: String
    
    var body: some View {
        VStack {
            Image(imageResource)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            Text(title)
                .font(.title2)
                .foregroundStyle(.accent)
                .padding()
            Text(description)
                .foregroundStyle(.primary)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
        }
    }
}

#Preview {
    EmptyStateView(title: "No favorites yet...", imageResource: .noFavMovies, description: "Go to Movies tab and add movies to your favs!")
}
