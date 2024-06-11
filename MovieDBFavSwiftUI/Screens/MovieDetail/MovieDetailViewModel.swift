//
//  MovieDetailViewController.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 04/05/24.
//

import Foundation

@MainActor
final class MovieDetailViewModel: ObservableObject {
    var selectedMovieID: Int
    @Published var movie: Movie?
    @Published var alertItem = AlertItem()
    @Published var isLoading: Bool = true
    var isFavorite: Bool {
        get {
            PersistenceManager.shared.isMovieFavorite(moveId: self.selectedMovieID)
        }
        set {
            isLoading = true
            guard let movie = self.movie else { return }
            
            do {
                if newValue {
                    try PersistenceManager.shared.update(with: movie, actionType: .add)
                } else {
                    try PersistenceManager.shared.update(with: movie, actionType: .remove)
                }
                isLoading = false
            } catch {
                isLoading = false
                if let persintenceError = error as? PersistenceError {
                    alertItem.set(title: "Something went wrong", message: persintenceError.rawValue)
                } else {
                    alertItem.set(title: "Something went wrong", message: "Unable to get favorites. Please try again later.")
                }
            }
        }
    }
    
    init(selectedMovieID: Int) {
        self.selectedMovieID = selectedMovieID
    }
    
    func getMovie() async {
        isLoading = true
        
        do {
            self.movie = try await NetworkManager.shared.getMovieDetail(movieId: selectedMovieID)
            
            isLoading = false
            
        } catch {
            isLoading = false
            
            if let networkError = error as? NetworkError {
                alertItem.set(title: "Something went wrong", message: networkError.description)
            } else {
                alertItem.set(title: "Something went wrong", message: "Unable to connect to the server. Please try again later.")
            }
        }
    }
}
