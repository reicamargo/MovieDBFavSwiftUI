//
//  NetworkError.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 06/05/24.
//

enum NetworkError: String, Error {
    case invalidURL = "Invalid URL. Something's wrong with the URL passed..."
    case invalidData = "Invalid Data. Couldn't convert data"
    case invalidResponse = "Invalid Response"
    case invalidParameterSearch = "It was not possible to search movies with this parameter. Please try again..."
}
