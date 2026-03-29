//
//  MockDataService.swift
//  SplitwiseClone
//
//  Created by Khushal on 29/03/2026.
//

import Foundation

class MockDataService {
    static func fetchOverviewExpenses() async throws -> [Expense] {
        guard let url = Bundle.main.url(forResource: "overviewExpenses", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }

        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode([Expense].self, from: data)
    }

    static func fetchExpenses() async throws -> [ExpenseItem] {
        guard let url = Bundle.main.url(forResource: "expenses", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }

        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode([ExpenseItem].self, from: data)
    }
}
