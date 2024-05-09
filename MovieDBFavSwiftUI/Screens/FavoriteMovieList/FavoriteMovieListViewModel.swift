//
//  FavoriteMovieListViewModel.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 04/05/24.
//

import Foundation

@MainActor
final class FavoriteMovieListViewModel: ObservableObject {
    @Published var filteredFavorites: [Movie] = []
    @Published var alertItem = AlertItem()
    @Published var isLoading: Bool = false
    @Published var filter: SearchFilter = .byTitle
    
    var favoriteSearch = "" {
        didSet {
            if favoriteSearch.isEmpty {
                loadFavorites()
            } else {
                filterFavorites()
            }
        }
    }
    
    private var favorites: [Movie] = [] {
        didSet {
            self.filteredFavorites = favorites
        }
    }
    
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
    
    func remove(attOffsets indexOffset: IndexSet) {
        guard let index = indexOffset.first else { return }
        let movie = filteredFavorites[index]

        do {
            try PersistenceManager.shared.update(with: movie, actionType: .remove)
            filteredFavorites.remove(atOffsets: indexOffset)
            
        } catch {
            
            if let persintenceError = error as? PersistenceError {
                alertItem.set(title: "Something's went wrong", message: persintenceError.rawValue)
            } else {
                alertItem.set(title: "Something's went wrong", message: "Unable to get favorites. Please try again later.")
            }
        }
    }
    
    private func filterFavorites() {
        switch filter {
        case .byTitle:
            filteredFavorites = favorites.filter { $0.title.localizedCaseInsensitiveContains(favoriteSearch) }
        
        case .byReleaseYear:
            guard let searchYear = Int(favoriteSearch) else { return }
            
            if searchYear > 1000 {
                filteredFavorites = favorites.filter {
                    let calendar = Calendar.current
                    return calendar.component(.year, from: $0.releaseDate) == searchYear
                }
            } else {
                filteredFavorites = favorites
            }
        
        case .byMostPopular:
            filteredFavorites = favorites.sorted { $0.voteAverage > $1.voteAverage }
        }
    }
}
