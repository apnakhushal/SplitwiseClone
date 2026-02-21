//
//  ExpenseFilter.swift
//  SplitwiseClone
//
//  Created by Khushal on 20/02/2026.
//

import Foundation

enum ExpenseFilter: String, CaseIterable {
    case pendingDues = "Pending Dues"
    case pendingCredits = "Pending Credits"
    case all = "All"
    case none = "None"

    var dueType: ExpenseType {
        switch self {
        case .pendingDues:
            return .debt
        case .pendingCredits:
            return .credit
        default:
            return .settled
        }
    }
}
