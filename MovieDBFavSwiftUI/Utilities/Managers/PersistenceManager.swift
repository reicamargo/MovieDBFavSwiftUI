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
    
    func isMovieFavorite(moveId: Int) -> Bool {
        do {
            let favorites = try loadFavorites()
            return favorites.contains { $0.id == moveId }
        } catch {
            return false
        }
    }
    
    private func save(favorites: [Movie]) throws {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            UserDefaults.standard.set(encodedFavorites, forKey: Keys.favorites)
            return
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

final class Keys {
    static let favorites = "myFavorites"
    
    private init() {}
}
