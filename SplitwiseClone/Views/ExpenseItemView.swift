//
//  ExpenseItemView.swift
//  SplitwiseClone
//
//  Created by Khushal on 28/03/2026.
//

import SwiftUI

struct ExpenseItemView: View {
    @Binding var expenseItem: ExpenseItem

    var body: some View {
        HStack {
            Spacer(minLength: 5)

            VStack(alignment: .center) {
                Text(expenseItem.formattedMonth)
                Text(expenseItem.formattedDay)
            }
            Spacer(minLength: 5)
            expenseItem.expenseCategory?.icon
                .resizable()
                .frame(width: 45, height: 45)
            Spacer(minLength: 5)
            VStack(alignment: .leading) {
                Text(expenseItem.title ?? "")
                    .lineLimit(1)
                Text(expenseItem.paymentStatement)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
            Spacer(minLength: 5)
            VStack(alignment: .trailing) {
                Text(expenseItem.dueStatement)
                    .font(.caption)
                    .lineLimit(1)
                Text(expenseItem.formattedDueAmount)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
            Spacer(minLength: 5)
        }
    }
}

#Preview {
    ExpenseItemView(expenseItem: .constant(
        ExpenseItem(title: "12th Feb Taxi going",
                    paidBy: "Khushal",
                    dueAmount: 9.0,
                    totalAmount: 18.0,
                    transactionDate: Date(),
                    dueType: .credit,
                    expenseCategory: .taxi,
                    groupName: "")))
}
