//
//  LogoImage.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 04/05/24.
//

import SwiftUI

struct LogoImageView: View {
    var body: some View {
        Image(.themovieDBLogo)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200)
    }
}

#Preview {
    LogoImageView()
}
