//
//  ExpenseCategory.swift
//  SplitwiseClone
//
//  Created by Khushal on 29/03/2026.
//

import SwiftUI

enum ExpenseCategory: String, Codable {
    case food
    case travel
    case taxi
    case movie
    case shopping
    case birthday
    case others

    var icon: Image {
        switch self {
        case .food:
            Image(.food)
        case .travel:
            Image(.travel)
        case .taxi:
            Image(.taxi)
        case .movie:
            Image(.movie)
        case .shopping:
            Image(.shopping)
        case .birthday:
            Image(.birthday)
        case .others:
            Image(.others)
        }
    }
}
