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
    
    init(selectedMovieID: Int) {
        self.selectedMovieID = selectedMovieID
    }
    
    func getMovie() async {
        isLoading = true
        do {
            self.movie = try await NetworkManager.shared.getMovieBy(id: self.selectedMovieID)
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
