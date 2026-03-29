//
//  MemberExpenseView.swift
//  SplitwiseClone
//
//  Created by apple on 17.01.26.
//

import SwiftUI

struct MemberExpenseView: View {
    let memberExpense: Expense
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(memberExpense.profileImage ?? "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40.0, height: 40.0)
                        .clipShape(Circle())
                    Text(memberExpense.memberName ?? "")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.black.opacity(0.8))
                    Spacer()
                    VStack(alignment: .trailing) {

                        Text(memberExpense.dueType?.oweText ?? "")
                            .foregroundStyle(memberExpense.dueType?.highlightedColor ?? .red)
                            .font(.system(size: memberExpense.isSettledUpOrNoBalance ? 14 : 12))

                        if !memberExpense.isSettledUpOrNoBalance {
                            Text("AED \(String(format: "%.2f", memberExpense.totalDue ?? 0))")
                                .foregroundStyle(memberExpense.dueType?.highlightedColor  ?? .red)
                                .font(.system(size: 16))
                        }
                    }
                }
            }
            VStack{
                HStack(alignment: .top) {
                    if memberExpense.expensesOverview.count > 0 {
                        TreePathView(numberOfBranches: .constant(memberExpense.expensesOverview.count))
                    }
                    VStack(alignment: .leading) {
                        
                        ForEach(memberExpense.expensesOverview, id: \.self) { expenseOverview in
                            Text(
                                TextFormatters.formatExpenseText(
                                    fullText: expenseOverview.getOverviewSummary(with: memberExpense.memberName ?? ""),
                                    highlighted: "AED \(expenseOverview.dueAmount ?? 0)",
                                    color: expenseOverview.dueType?.highlightedColor ?? .red)
                            )
                            .modifier(ExpenseListStyle())
                        }
                    }.padding(.leading, -45)
                }
            }
        }
    }
}


struct ExpenseListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color(.gray))
            .font(.system(size: 13, weight: .regular))
            .lineLimit(1)
            .frame(height: 10)
    }
}

struct TreePathView: View {
    @Binding var numberOfBranches: Int
    var body: some View {
        Path { path in
            guard let totalBranches = ExpenseBranch(rawValue: numberOfBranches) else { return }
            path.move(to: CGPoint(x: -65, y: 0))
            path.addLine(to: CGPoint(x: -65, y: totalBranches.verticalOffset))

            for index in 1...numberOfBranches {
                guard let expenseBranch = ExpenseBranch(rawValue: index) else { return }
                path.move(to: CGPoint(x: -65, y: expenseBranch.verticalOffset))
                path.addLine(to: CGPoint(x: -45, y: expenseBranch.verticalOffset))
            }
        }
        .stroke(Color(.systemGray4), lineWidth: 0.5)
        .frame(width: 1, height: 1)
    }
}

enum ExpenseBranch: Int {
    case first = 1
    case second = 2
    case third = 3
    
    var verticalOffset: Int {
        switch self {
        case .first: 5
        case .second: 23
        case .third: 42
        }
    }
}

#Preview {
    MemberExpenseView(
        memberExpense: Expense(
            memberName: "Althaf bhai",
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
            ]))
}
