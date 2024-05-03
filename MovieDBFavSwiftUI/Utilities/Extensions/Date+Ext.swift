//
//  Date+Ext.swift
//  MovieDBFavSwiftUI
//
//  Created by Reinaldo Camargo on 03/05/24.
//

import Foundation

extension Date {
    func convertToDisplayFormat() -> String {
        return formatted(.dateTime.month(.wide).year())
        
    }
}
