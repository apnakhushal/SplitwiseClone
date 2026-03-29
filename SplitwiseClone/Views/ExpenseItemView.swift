//
//  ExpenseItemView.swift
//  SplitwiseClone
//
//  Created by Khushal on 28/03/2026.
//

import SwiftUI

struct ExpenseItemView: View {
    var expenseItem: ExpenseItem

    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            VStack(alignment: .center, spacing: 0) {
                Text(expenseItem.formattedMonth)
                Text(expenseItem.formattedDay)
            }

            expenseItem.expenseCategory?.icon
                .resizable()
                .frame(width: 45, height: 45)

            VStack(alignment: .leading, spacing: 5) {
                Text(expenseItem.title ?? "")
                    .lineLimit(1)
                Text(expenseItem.paymentStatement)
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 5) {
                Text(expenseItem.dueStatement)
                    .font(.caption)
                    .foregroundStyle(expenseItem.dueType?.highlightedColor  ?? .red)
                    .lineLimit(1)

                Text(expenseItem.formattedDueAmount)
                    .font(.caption)
                    .foregroundStyle(expenseItem.dueType?.highlightedColor  ?? .red)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}

#Preview {
    ExpenseItemView(expenseItem: ExpenseItem(
        title: "12th Feb Taxi going",
        paidBy: "Khushal",
        dueAmount: 9.0,
        totalAmount: 18.0,
        transactionDate: Date(),
        dueType: .credit,
        expenseCategory: .taxi,
        groupName: ""))
}
