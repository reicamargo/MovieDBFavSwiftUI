//
//  NetworkManager.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "0565e80378fe44805112fa7d7d3afecc"
    private let decoder = JSONDecoder()
    
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom({ decoder in
            let data = try decoder.singleValueContainer().decode(String.self)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.date(from: data) ?? Date()
        })
    }
    
    func getPopularMovies(page: Int) async throws -> [Movie] {
        let stringURL = "\(baseURL)discover/movie?include_adult=false&language=en-US&page=\(String(page))&api_key=\(apiKey)&sort_by=popularity.desc"
        
        guard let url = URL(string: stringURL) else {
            throw NetworkError.invalidParameterSearch
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            return try decoder.decode(MovieDBResponse.self, from: data).results
        } catch {
            throw NetworkError.invalidData
            
        }
    }
    
    func getMoviesByTitle(_ title: String, page: Int) async throws -> [Movie] {
        let stringURL = "\(baseURL)search/movie?query=\(title)&include_adult=false&language=en-US&page=\(String(page))&api_key=\(apiKey)&sort_by=popularity.desc"
        
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
    case invalidParameterSearch = "It was not possible to search movies with this parameter. Please try again..."
}
