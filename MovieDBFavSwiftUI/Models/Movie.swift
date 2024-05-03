//
//  Movie.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let voteAverage: Double
    let releaseDate: Date
    var genres: [String]?
}

struct MockMovie {
    static let movieOne = Movie(id: 693134, title: "Dune: Part Two", overview: "Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.", posterPath: "/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg", voteAverage: 8.24, releaseDate: Date.now)
    static let movieTwo = Movie(id: 823464, title: "Godzilla x Kong: The New Empire", overview: "Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.", posterPath: "/tMefBSflR6PGQLv7WvFPpKLZkyk.jpg", voteAverage: 6.53, releaseDate: Date.now)
    static let severalMovies = [movieOne, movieTwo, movieOne]
}
