//
//  Expense.swift
//  SplitwiseClone
//
//  Created by apple on 17.01.26.
//

import Foundation

struct Expense: Codable, Hashable {
    let memberName: String?
    let totalDue: Double?
    let dueType: ExpenseType?
    let profileImage: String?
    let expensesOverview: [ExpenseOverview]
}

extension Expense {
    var formattedTotalDueAmount: String {
        guard let totalDue else { return "" }
        return "AED \(totalDue.formatted(.number.precision(.fractionLength(2))))"
    }

    var isSettledUpOrNoBalance: Bool {
        return dueType == .settled || dueType == .noBalance
    }

    var summary: String {
        guard let dueType else { return "" }
        var prefix = ""

        switch dueType {
        case .debt: prefix = "You owe "
        case .credit: prefix = "You are owed "
        default: prefix = ""
        }

        return prefix + formattedTotalDueAmount + " " + "overall"
    }
}
