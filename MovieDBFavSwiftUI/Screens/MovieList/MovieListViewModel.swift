//
//  MovieListViewController.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import SwiftUI

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var searchedMovies: [Movie] = []
    @Published var alertItem = AlertItem()
    @Published var isLoading: Bool = true
    @Published var filter: SearchFilter = .byMostPopular
    var page = 1
    
    var movieSearch: String = "" {
        didSet {
            
            if movieSearch.isEmpty {
                self.page = 1
                self.searchedMovies.removeAll()
                Task {
                    await loadMovies(filter: .byMostPopular)
                }
            }
            else if movieSearch.count > 2 && filter != .byMostPopular {
                self.searchedMovies.removeAll()
                Task {
                    await loadMovies(filter: filter)
                }
            }
        }
    }
    
    func loadMovies(filter: SearchFilter) async {
        isLoading = true
        var movies: [Movie] = []
        
        do {
            switch filter {
            case .byTitle:
                movies = try await NetworkManager.shared.getMovieBy(filter, term: movieSearch, page: page)
            
            case .byMostPopular:
                movies = try await NetworkManager.shared.getMovieBy(filter, page: page)
            
            case .byReleaseYear:
                guard let year = Int(movieSearch), year > 1000 else {
                    isLoading = false
                    return
                }
                
                movies = try await NetworkManager.shared.getMovieBy(.byReleaseYear, term: movieSearch, page: page)
            }
            
            searchedMovies.append(contentsOf: movies)
            
            isLoading = false
            
        } catch {
            isLoading = false
            
            if let networkError = error as? NetworkError {
                alertItem.set(title: "Something's went wrong", message: networkError.description)
            } else {
                alertItem.set(title: "Something's went wrong", message: "Unable to connect to the server. Please try again later.")
            }
        }        
    }
}
