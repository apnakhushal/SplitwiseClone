//
//  ExpenseItem.swift
//  SplitwiseClone
//
//  Created by Khushal on 29/03/2026.
//

import Foundation

struct ExpenseItem: Codable, Identifiable, Hashable {
    let id = UUID()
    let title: String?
    let paidBy: String?
    let dueAmount: Double?
    let totalAmount: Double?
    let transactionDate: Date?
    let dueType: ExpenseType?
    let expenseCategory: ExpenseCategory?
    let groupName: String?

    enum CodingKeys: String, CodingKey {
        case title, paidBy, dueAmount, totalAmount, transactionDate, dueType, expenseCategory, groupName
    }
}

extension ExpenseItem {
    var formattedDay: String {
        transactionDate?.formatted(.dateTime.day()) ?? ""
    }

    var formattedMonth: String {
        transactionDate?.formatted(.dateTime.month(.abbreviated)) ?? ""
    }

    var formattedDueAmount: String {
        guard let dueAmount else { return "" }
        return "AED \(dueAmount.formatted(.number.precision(.fractionLength(2))))"
    }

    var isSettledUpOrNoBalance: Bool {
        return dueType == .settled || dueType == .noBalance
    }

    var paymentStatement: String {
        guard let totalAmount, let paidBy else { return "" }
        switch dueType {
        case .credit:
            return "You paid AED \(totalAmount.formatted(.number.precision(.fractionLength(2))))"
        case .debt, .noBalance:
            return "\(paidBy) paid AED \(totalAmount.formatted(.number.precision(.fractionLength(2))))"
        default:
            return ""
        }
    }

    var dueStatement: String {
        switch dueType {
        case .credit: "you lent"
        case .debt: "you borrowed"
        case .settled: "settled up"
        case .noBalance: "no balance"
        default: "no balance"
        }
    }
}
