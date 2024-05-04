//
//  MovieListViewController.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var movieSearch: String = ""
    @Published var alertItem = AlertItem()
    @Published var isLoading: Bool = true
    
    
    func loadPopularMovies() async {
        isLoading = true
        do {
            movies = try await NetworkManager.shared.getPopularMovies(page: 1)
            isLoading = false
        } catch {
            isLoading = false
            if let networkError = error as? NetworkError {
                alertItem.set(title: "Something's went wrong", message: networkError.rawValue)
            } else {
                alertItem.set(title: "Something's went wrong", message: "Unable to connect to the server. Please try again later.")
            }
        }
    }
    
    func searchMoviesByTitle() async {
        guard !movieSearch.isEmpty else { return }
        
        isLoading = true
        
        do {
            movies = try await NetworkManager.shared.getMoviesByTitle(movieSearch, page: 1)
            isLoading = false
        } catch {
            isLoading = false
            if let networkError = error as? NetworkError {
                alertItem.set(title: "Something's went wrong", message: networkError.rawValue)
            } else {
                alertItem.set(title: "Something's went wrong", message: "Unable to connect to the server. Please try again later.")
            }
        }
    }
}
