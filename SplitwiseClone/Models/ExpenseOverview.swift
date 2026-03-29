//
//  ExpenseOverview.swift
//  SplitwiseClone
//
//  Created by Khushal on 29/03/2026.
//

import Foundation

struct ExpenseOverview: Codable, Hashable {
    let dueType: ExpenseType?
    let groupName: String?
    let dueAmount: Double?
    
    func getOverviewSummary(with memberName: String) -> String {
        guard let dueType, let dueAmount, let groupName else { return "" }
        return dueType.owesPrefix + memberName + " " + dueType.owesSuffix + "AED " + String(dueAmount) + " " + "in" + " " + "\"\(groupName)\""
    }
}
