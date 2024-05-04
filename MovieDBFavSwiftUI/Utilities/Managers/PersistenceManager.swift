//
//  PersistenceManager.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 04/05/24.
//

import Foundation

final class PersistenceManager {
    static let shared = PersistenceManager()
    
    private init() { }
    
    func loadFavorites() throws -> [Movie] {
        guard let favoriteData = UserDefaults.standard.object(forKey: Keys.favorites) as? Data else { return [] }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Movie].self, from: favoriteData)
        } catch {
            throw PersistenceError.invalidFavoriteData
        }
    }
    
    func save(favorites: [Movie]) throws {
        do {
            let encoder = JSONEncoder()
            let favoritesEncoded = try encoder.encode(favorites)
            UserDefaults.standard.set(favoritesEncoded, forKey: Keys.favorites)
        } catch {
            throw PersistenceError.unableToSave
        }
    }
    
    func update(with favorite: Movie, actionType: PersistenceActionType) throws {
        var favorites = try loadFavorites()
        
        switch actionType {
        case .add:
            favorites.append(favorite)
        case .remove:
            if let index = favorites.firstIndex(of: favorite) {
                favorites.remove(at: index)
            } else {
                throw PersistenceError.indexNotFound
            }
        }
        try save(favorites: favorites)
    }
}

enum PersistenceActionType {
    case add, remove
}

final class Keys {
    static let favorites = "myFavorites"
    
    private init() {}
}

enum PersistenceError: String, Error {
    case invalidFavoriteData = "Unable to load you favorites. Try again later."
    case unableToSave = "Unable to save to favorites..."
    case indexNotFound = "Movie wasn't found in favorites"
}
