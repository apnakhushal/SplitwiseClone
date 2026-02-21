//
//  Expense.swift
//  SplitwiseClone
//
//  Created by apple on 17.01.26.
//

import Foundation
import SwiftUI

struct Expense: Codable, Hashable {
    let memberName: String?
    let totalDue: Double?
    let dueType: ExpenseType?
    let profileImage: String?
    let expensesOverview: [ExpenseOverview]
}

struct ExpenseOverview: Codable, Hashable {
    let dueType: ExpenseType?
    let groupName: String?
    let dueAmount: Double?
    
    func getOverviewSummary(with memberName: String) -> String {
        guard let dueType, let dueAmount, let groupName else { return "" }
        return dueType.owesPrefix + memberName + " " + dueType.owesSuffix + "AED " + String(dueAmount) + " " + "in" + " " + "\"\(groupName)\""
    }
}

enum ExpenseType: String, Codable {
    case credit
    case debt
    case settled
}

extension ExpenseType {
    var highlightedColor: Color {
        switch self {
        case .credit: Color(hex: "1BA14B")
        case .debt: .red
        default: Color(.systemGray4)
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
        }
    }
}

extension Expense {
    static var expensesMockData: [Expense] = [
        Expense(memberName: "Akash Nemade",
                totalDue: 5.75,
                dueType: .credit,
                profileImage: "person_1",
                expensesOverview: []),
        Expense(memberName: "Ali Ahmed",
                totalDue: 11.13,
                dueType: .credit,
                profileImage: "person_2",
                expensesOverview: []),
        Expense(memberName: "Althaf bhai",
                totalDue: 10.95,
                dueType: .debt,
                profileImage: "person_3",
                expensesOverview: [
                    ExpenseOverview(dueType: .debt,
                                    groupName: "non-group",
                                    dueAmount: 60.20),
                    ExpenseOverview(dueType: .credit,
                                    groupName: "Food",
                                    dueAmount: 36),
                    ExpenseOverview(dueType: .credit,
                                    groupName: "movie group",
                                    dueAmount: 13.25)
                ]),
        Expense(memberName: "Ankit Raut",
                totalDue: 12.50,
                dueType: .debt,
                profileImage: "person_4",
                expensesOverview: [
                    ExpenseOverview(dueType: .debt,
                                    groupName: "movie group",
                                    dueAmount: 19.50),
                    ExpenseOverview(dueType: .credit,
                                    groupName: "non-group",
                                    dueAmount: 7)
                ]),
        Expense(memberName: "Ashish Baghel",
                totalDue: 86.67,
                dueType: .credit,
                profileImage: "person_5",
                expensesOverview: []),
        Expense(memberName: "Avinash",
                totalDue: 12.50,
                dueType: .credit,
                profileImage: "person_6",
                expensesOverview: []),
        Expense(memberName: "Hassaan Raza",
                totalDue: 80.78,
                dueType: .credit,
                profileImage: "person_1",
                expensesOverview: []),
        Expense(memberName: "Hemant",
                totalDue: 60.00,
                dueType: .credit,
                profileImage: "person_2",
                expensesOverview: []),
        Expense(memberName: "Ibrahim",
                totalDue: 10,
                dueType: .credit,
                profileImage: "person_3",
                expensesOverview: []),
        Expense(memberName: "Iram Khan",
                totalDue: 42.50,
                dueType: .credit,
                profileImage: "person_4",
                expensesOverview: []),
        Expense(memberName: "Jyoti Kumari",
                totalDue: 5.75,
                dueType: .credit,
                profileImage: "person_5",
                expensesOverview: []),
        Expense(memberName: "Malli ADIB UAE",
                totalDue: 14.75,
                dueType: .credit,
                profileImage: "person_6",
                expensesOverview: []),
        Expense(memberName: "Omer",
                totalDue: 15.26,
                dueType: .credit,
                profileImage: "person_1",
                expensesOverview: [
                    ExpenseOverview(dueType: .credit,
                                    groupName: "non-group",
                                    dueAmount: 28.46),
                    ExpenseOverview(dueType: .debt,
                                    groupName: "Badminton ADIB",
                                    dueAmount: 13.20)
                ]),
        Expense(memberName: "Preeteesh",
                totalDue: 4928.20,
                dueType: .debt,
                profileImage: "person_2",
                expensesOverview: [
                    ExpenseOverview(dueType: .debt,
                                    groupName: "non-group",
                                    dueAmount: 4504.02),
                    ExpenseOverview(dueType: .debt,
                                    groupName: "Food",
                                    dueAmount: 424.18)
                ]),
        Expense(memberName: "Satish",
                totalDue: 0,
                dueType: .settled,
                profileImage: "person_3",
                expensesOverview: []),
        Expense(memberName: "Shiv",
                totalDue: 15,
                dueType: .credit,
                profileImage: "person_4",
                expensesOverview: []),
        Expense(memberName: "Sony Choudhary",
                totalDue: 43.64,
                dueType: .credit,
                profileImage: "person_5",
                expensesOverview: [
                    ExpenseOverview(dueType: .credit,
                                    groupName: "non-group",
                                    dueAmount: 21.97),
                    ExpenseOverview(dueType: .credit,
                                    groupName: "Flatmates",
                                    dueAmount: 21.67)
                ]),
        Expense(memberName: "Vaibhav Verma",
                totalDue: 150.50,
                dueType: .credit,
                profileImage: "person_6",
                expensesOverview: []),
        Expense(memberName: "Viraj ADIB",
                totalDue: 175,
                dueType: .debt,
                profileImage: "person_1",
                expensesOverview: [])
    ]
}
