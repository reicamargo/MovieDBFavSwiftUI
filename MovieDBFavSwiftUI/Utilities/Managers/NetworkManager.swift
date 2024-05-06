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
    
    func getMovieBy(_ filter: SearchFilter, term: String? = nil, page: Int)  async throws -> [Movie] {
        var stringURL = ""
        
        switch filter {
        case .byTitle:
            guard let term else { throw NetworkError.invalidParameterSearch }
            
            stringURL = "\(baseURL)search/movie?query=\(term)&include_adult=false&language=en-US&page=\(String(page))&sort_by=popularity.desc&api_key=\(apiKey)"
            
        case .byMostPopular:
            stringURL = "\(baseURL)discover/movie?include_adult=false&language=en-US&page=\(String(page))&sort_by=popularity.desc&api_key=\(apiKey)"
            
        case .byReleaseYear:
            guard let term else { throw NetworkError.invalidParameterSearch }
            
            stringURL = "\(baseURL)discover/movie?include_adult=false&include_video=false&language=en-US&page=\(String(page))&primary_release_year=\(term)&sort_by=primary_release_date.desc&api_key=\(apiKey)"
        }
        
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
    
    func getMovieDetail(movieId: Int) async throws -> Movie {
        let stringURL = "\(baseURL)movie/\(movieId)?language=en-US&api_key=\(apiKey)"
        
        guard let url = URL(string: stringURL) else {
            throw NetworkError.invalidParameterSearch
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            return try decoder.decode(Movie.self, from: data)
            
        } catch {
            throw NetworkError.invalidData
            
        }
    }
}
