//
//  Genre.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 04/05/24.
//

import Foundation

struct Genre: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
}
