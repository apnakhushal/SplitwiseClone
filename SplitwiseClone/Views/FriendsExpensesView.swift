//
//  FriendsExpensesView.swift
//  SplitwiseClone
//
//  Created by apple on 18.01.26.
//

import SwiftUI

struct FriendsExpensesView: View {
    @State private var expensesMockData = Expense.expensesMockData
    @State private var isShowingSheet = false
    @State private var selectedFilterType: ExpenseFilter = .all
    let availableFilterOptions: [ExpenseFilter] = [.all, .pendingDues, .pendingCredits]
    
    @State private var searchText = ""
    private var isSearchActive: Bool {
        !searchText.isEmpty
    }
    
    private var filteredExpenses: [Expense] {
        if searchText.isEmpty && selectedFilterType == .all {
            return expensesMockData
        } else {
            let searchedExpenses = searchText.isEmpty ? expensesMockData : expensesMockData.filter {
                $0.memberName?.localizedCaseInsensitiveContains(searchText) ?? false
            }
            return selectedFilterType == .all ? searchedExpenses : searchedExpenses.filter {
                $0.dueType == selectedFilterType.dueType
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    if !isSearchActive {
                        Text(
                            TextFormatters.formatExpenseText(
                                fullText: "Overall, you owe AED 4,562.42",
                                highlighted: "AED 4,562.42",
                                color: Color.red)
                        )
                        .font(.system(size: 18, weight: .bold))
                        Spacer()
                        Button {
                            isShowingSheet.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        }
                        .sheet(isPresented: $isShowingSheet) {
                            VStack(alignment: .leading) {
                                Text("Select expense type")
                                    .font(.title2)
                                    .bold()
                                    .padding([.top, .leading])
                                
                                List(availableFilterOptions, id: \.self) { filterType in
                                    HStack {
                                        Text(filterType.rawValue)
                                        Spacer()
                                        if selectedFilterType == filterType {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    .contentShape(Rectangle()) // Makes the whole row tappable
                                    .onTapGesture {
                                        selectedFilterType = filterType
                                        isShowingSheet = false // Auto-dismiss after selection
                                    }
                                }
                                .listStyle(.plain)
                            }
                            .presentationDetents([.medium]) // Keeps it as a bottom "drawer"
                            .presentationDragIndicator(.visible)
                            .presentationBackground(.white)
                        }
                    }
                }
                Spacer()
                List(
                    Binding(
                        get: { filteredExpenses },
                        set: { _ in }
                    ) , id: \.self) { expense in
                        MemberExpenseView(memberExpense: expense)
                            .listRowSeparator(.hidden)
                            .listRowInsets(
                                EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
                            )
                    }
                    .environment(\.defaultMinListRowHeight, 10)
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    .background(Color.clear)
                    .searchable(text: $searchText)
            }.padding()
        }
    }
}

#Preview {
    FriendsExpensesView()
}
