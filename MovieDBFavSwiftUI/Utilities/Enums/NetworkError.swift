//
//  NetworkError.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 06/05/24.
//

enum NetworkError: Error {
    case invalidURL ,invalidData ,invalidResponse, invalidParameterSearch
    
    var description: String {
        switch self {
            
        case .invalidURL:
            return "Invalid URL. Something's wrong with the URL passed..."
        case .invalidData:
            return "Invalid Data. Couldn't convert data"
        case .invalidResponse:
            return "Invalid Response"
        case .invalidParameterSearch:
            return "It was not possible to search movies with this parameter. Please try again..."
        }
    }
}
