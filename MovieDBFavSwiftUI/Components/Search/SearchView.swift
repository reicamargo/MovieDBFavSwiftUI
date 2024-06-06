//
//  SearchView.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 05/05/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var textSearch: String
    @Binding var filter: SearchFilter
    
    var body: some View {
        VStack {
            TextField("Search for movies", text: $textSearch)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()
                .keyboardType(.default)
            
                Picker("Filter", selection: $filter) {
                    Text("Most popular").tag(SearchFilter.byMostPopular)
                    Text("Movie title").tag(SearchFilter.byTitle)
                    Text("Release year").tag(SearchFilter.byReleaseYear)
                }
                .pickerStyle(.segmented)
                .onChange(of: filter) {
                    textSearch = ""
                }
        }
        .padding(20)
    }
}

#Preview {
    SearchView(textSearch: Binding<String>.constant(""), filter: Binding<SearchFilter>.constant(.byMostPopular))
}
