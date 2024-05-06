//
//  FavoriteButton.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 04/05/24.
//

import SwiftUI

struct FavoriteButton: View {
    var favorite: Bool
    
    var body: some View {
        Label(favorite ? "Unfavorite" : "Favorite", systemImage: favorite ? "star" : "star.fill")
            .symbolRenderingMode(.multicolor)
            .foregroundColor(.accentColor)
    }
}

#Preview {
    FavoriteButton(favorite: true)
}
