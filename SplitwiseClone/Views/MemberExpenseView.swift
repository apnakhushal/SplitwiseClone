//
//  MemberExpenseView.swift
//  SplitwiseClone
//
//  Created by apple on 17.01.26.
//

import SwiftUI

struct MemberExpenseView: View {
    @Binding var memberExpense: Expense
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(memberExpense.profileImage ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50.0, height: 50.0)
                    .clipShape(Circle())
                    .padding(.leading)
                Text(memberExpense.memberName ?? "")
                    .font(.system(size: 15, weight: .regular))
                Spacer()
                VStack(alignment: .trailing) {
                    Text(memberExpense.dueType?.oweText ?? "")
                        .foregroundStyle(memberExpense.dueType?.highlightedColor ?? .red)
                        .font(.system(size: 10))
                    Text("AED \(String(format: "%.2f", memberExpense.totalDue ?? 0))")
                        .foregroundStyle(memberExpense.dueType?.highlightedColor  ?? .red)
                        .font(.system(size: 14))
                }.padding(.trailing)
            }
        }
        VStack{
            HStack(alignment: .top) {
                if memberExpense.expensesOverview.count > 0 {
                    TreePathView(numberOfBranches: .constant(memberExpense.expensesOverview.count))
                        .padding(.leading)
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
                }
            }
        }
    }
}


struct ExpenseListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color(.gray))
            .font(.system(size: 12, weight: .regular))
            .lineLimit(1)
            .frame(height: 10)
    }
}

struct TreePathView: View {
    @Binding var numberOfBranches: Int
    var body: some View {
        Path { path in
            guard let totalBranches = ExpenseBranch(rawValue: numberOfBranches) else { return }
            path.move(to: CGPoint(x: 20, y: 0))
            path.addLine(to: CGPoint(x: 20, y: totalBranches.verticalOffset))

            for index in 1...numberOfBranches {
                guard let expenseBranch = ExpenseBranch(rawValue: index) else { return }
                path.move(to: CGPoint(x: 20, y: expenseBranch.verticalOffset))
                path.addLine(to: CGPoint(x: 50, y: expenseBranch.verticalOffset))
            }
        }
        .stroke(Color(.systemGray4), lineWidth: 0.5)
        .frame(width: 50, height: 45)
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
    MemberExpenseView(memberExpense: .constant(Expense(memberName: "Althaf bhai",
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
                                                       ])))
}
