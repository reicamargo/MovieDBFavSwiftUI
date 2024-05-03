//
//  NetworkManager.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.themoviedb.org/3/movie/"
    private let apiKey = "0565e80378fe44805112fa7d7d3afecc"
    private let decoder = JSONDecoder()
    
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom({ decoder in
            let data = try decoder.singleValueContainer().decode(String.self)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter.date(from: data) ?? Date()
        })
    }
    
    func getPopularMovies(page: Int) async throws -> [Movie] {
        let stringURL = "\(baseURL)popular?language=en-US&page=\(String(page))&api_key=\(apiKey)"
        
        guard let url = URL(string: stringURL) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            return try decoder.decode(MovieDBResponse.self, from: data).results
        } catch {
            throw NetworkError.invalidData
            
        }
        
    }
}

enum NetworkError: String, Error {
    case invalidURL = "Invalid URL. Something's wrong with the URL passed..."
    case invalidData = "Invalid Data. Couldn't convert data"
    case invalidResponse = "Invalid Response"
}
