//
//  PersistenceError.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 06/05/24.
//

enum PersistenceError: String, Error {
    case invalidFavoriteData = "Unable to load you favorites. Try again later."
    case unableToSave = "Unable to save to favorites..."
    case indexNotFound = "Movie wasn't found in favorites"
}
