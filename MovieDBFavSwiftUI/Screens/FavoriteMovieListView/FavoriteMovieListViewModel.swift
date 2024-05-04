//
//  FavoriteMovieListViewModel.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 04/05/24.
//

import Foundation

final class FavoriteMovieListViewModel: ObservableObject {
    @Published var favorites: [Movie] = []
    @Published var alertItem = AlertItem()
    @Published var isLoading: Bool = false
    
    func loadFavorites() {
        do {
            isLoading = true
            self.favorites = try PersistenceManager.shared.loadFavorites()
            isLoading = false
        } catch {
            isLoading = false
            if let persintenceError = error as? PersistenceError {
                alertItem.set(title: "Something's went wrong", message: persintenceError.rawValue)
            } else {
                alertItem.set(title: "Something's went wrong", message: "Unable to get favorites. Please try again later.")
            }
        }
        
    }
    
}
