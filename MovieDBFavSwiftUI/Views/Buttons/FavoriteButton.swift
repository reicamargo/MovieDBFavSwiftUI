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
        Label(favorite ? "Favorite" : "Not favorite", systemImage: favorite ? "star.fill" : "star")
            .symbolRenderingMode(.multicolor)
            .foregroundColor(.accentColor)
    }
}

#Preview {
    FavoriteButton(favorite: true)
}
