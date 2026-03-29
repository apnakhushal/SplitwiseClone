//
//  ExpenseType.swift
//  SplitwiseClone
//
//  Created by Khushal on 29/03/2026.
//

import SwiftUI

enum ExpenseType: String, Codable {
    case credit
    case debt
    case settled
    case noBalance
}

extension ExpenseType {
    var highlightedColor: Color {
        switch self {
        case .credit: Color(hex: "1BA14B")
        case .debt: .red
        default: Color(.gray)
        }
    }
    
    var owesPrefix: String {
        switch self {
        case .credit: ""
        case .debt: "You owe "
        default: ""
        }
    }
    
    var owesSuffix: String {
        switch self {
        case .credit: "owes you "
        case .debt: ""
        default: ""
        }
    }
    
    var oweText: String {
        switch self {
        case .credit: "owes you"
        case .debt: "you owe"
        case .settled: "settled up"
        case .noBalance: "no balance"
        }
    }

    var expenseMessage: String {
        switch self {
        case .credit: "you lent"
        case .debt: "you borrowed"
        case .settled: "settled up"
        case .noBalance: "no balance"
        }
    }
}
