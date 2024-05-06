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
    
    var mostPopularMovies: [Movie] = [] {
        didSet {
            self.searchedMovies = mostPopularMovies
        }
    }
    
    var movieSearch: String = "" {
        didSet {
            
            if movieSearch.isEmpty {
                self.searchedMovies = mostPopularMovies
            }
            else if movieSearch.count > 3 && filter != .byMostPopular {
                Task {
                    await loadMoviesBy(filter)
                }
            }
        }
    }
    
    func loadMoviesBy(_ searchBy: SearchFilter) async {
        isLoading = true
        
        do {
            switch searchBy {
            case .byTitle:
                searchedMovies = try await NetworkManager.shared.getMovieBy(searchBy, term: movieSearch, page: 1)
            
            case .byMostPopular:
                mostPopularMovies = try await NetworkManager.shared.getMovieBy(searchBy, page: 1)
            
            case .byReleaseYear:
                guard let year = Int(movieSearch), year > 1000 else {
                    isLoading = false
                    return
                }
                
                searchedMovies = try await NetworkManager.shared.getMovieBy(.byReleaseYear, term: movieSearch, page: 1)
            }
            
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
    
//    func loadPopularMovies() async {
//        isLoading = true
//        
//        do {
//            mostPopularMovies = try await NetworkManager.shared.getMovieBy(.byMostPopular, page: 1)
//            isLoading = false
//            
//        } catch {
//            isLoading = false
//            
//            if let networkError = error as? NetworkError {
//                alertItem.set(title: "Something's went wrong", message: networkError.rawValue)
//            } else {
//                alertItem.set(title: "Something's went wrong", message: "Unable to connect to the server. Please try again later.")
//            }
//        }
//    }
//    
//    private func searchMoviesByTitle() async {
//        isLoading = true
//        
//        do {
//            searchedMovies = try await NetworkManager.shared.getMovieBy(.byTitle, term: movieSearch, page: 1)
//            isLoading = false
//            
//        } catch {
//            isLoading = false
//            
//            if let networkError = error as? NetworkError {
//                alertItem.set(title: "Something's went wrong", message: networkError.rawValue)
//            } else {
//                alertItem.set(title: "Something's went wrong", message: "Unable to connect to the server. Please try again later.")
//            }
//        }
//    }
//    
//    private func searchMoviesByReleaseYear(_ releaseYear: String) async {
//        isLoading = true
//        
//        do {
//            searchedMovies = try await NetworkManager.shared.getMovieBy(.byReleaseYear, term: releaseYear, page: 1)
//            isLoading = false
//            
//        } catch {
//            isLoading = false
//            
//            if let networkError = error as? NetworkError {
//                alertItem.set(title: "Something's went wrong", message: networkError.rawValue)
//            } else {
//                alertItem.set(title: "Something's went wrong", message: "Unable to connect to the server. Please try again later.")
//            }
//        }
//    }
}
