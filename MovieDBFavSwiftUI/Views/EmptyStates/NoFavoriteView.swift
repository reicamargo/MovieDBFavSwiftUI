//
//  NoFavoriteView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

struct NoFavoriteView: View {
    var body: some View {
        VStack {
            Image(.sadFilm)
            Text("No favorites movies yet =(")
            Text("Go to Movies tab!")
            
        }
        .font(.title2)
        .foregroundStyle(.secondary)
    }
}

#Preview {
    NoFavoriteView()
}
