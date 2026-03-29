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
            VStack(alignment: .center, spacing: 2) {
                Text(expenseItem.formattedMonth)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.black.opacity(0.6))

                Text(expenseItem.formattedDay)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.black.opacity(0.6))
            }

            expenseItem.expenseCategory?.icon
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)

            VStack(alignment: .leading, spacing: 5) {
                Text(expenseItem.title ?? "")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.black.opacity(0.7))
                    .lineLimit(1)
                Text(expenseItem.paymentStatement)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color(.systemGray))
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {

                Text(expenseItem.dueStatement)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(expenseItem.dueType?.highlightedColor  ?? .red)
                    .lineLimit(1)

                if !expenseItem.isSettledUpOrNoBalance {
                    Text(expenseItem.formattedDueAmount)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(expenseItem.dueType?.highlightedColor  ?? .red)
                        .lineLimit(1)
                }
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
