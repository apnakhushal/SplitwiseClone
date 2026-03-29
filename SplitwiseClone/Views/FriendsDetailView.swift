//
//  FriendsDetailView.swift
//  SplitwiseClone
//
//  Created by Khushal on 01/03/2026.
//

import SwiftUI

struct FriendsDetailView: View {

    @Environment(\.dismiss) private var dismiss
    
    private let maxHeight: CGFloat = 220
    private let minHeight: CGFloat = 60

    @State private var scrollOffset: CGFloat = 0

    let expenseOverview: Expense

    @State private var expenses: [ExpenseItem] = []

    var body: some View {
        ZStack(alignment: .top) {
            
            ScrollView {
                VStack(spacing: 0) {
                    
                    // This spacer creates real scroll movement
                    Color.clear
                        .frame(height: maxHeight)
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .onAppear {
                                        scrollOffset = geo.frame(in: .named("scroll")).minY
                                    }
                                    .onChange(of: geo.frame(in: .named("scroll")).minY) { newValue in
                                        scrollOffset = newValue
                                    }
                            }
                        )

                    LazyVStack(spacing: 10) {
                        ForEach(expenses) { expenseItem in
                            ExpenseItemView(expenseItem: expenseItem)
                        }
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            
            header
        }
        .task {
            do {
                self.expenses = try await MockDataService.fetchExpenses()
            } catch {
                print("Failed to load: \(error)")
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea()
    }
    
    // MARK: - Header
    
    private var header: some View {
        ZStack(alignment: .bottom) {
            
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [Color.white, Color.white],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            // Large Content
            VStack(spacing: 12) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                    Spacer()
                }
                .padding(.leading)
                .foregroundColor(.white)
                Image(expenseOverview.profileImage ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60.0, height: 60.0)
                    .clipShape(Circle())
                    .opacity(largeOpacity)

                VStack(spacing: 4) {
                    Text(expenseOverview.memberName ?? "")
                        .font(.title2.bold())
                        .foregroundColor(.black.opacity(0.8))

                    Text(expenseOverview.summary)
                        .foregroundColor(expenseOverview.dueType?.highlightedColor)
                        .font(.system(size: 18, weight: .bold))
                }
                .opacity(largeOpacity)
            }
            .padding(.bottom, 20)
            
            // Compact Title Only
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                }
                Spacer()
                Text(expenseOverview.memberName ?? "")
                    .font(.title3.bold())
                    .foregroundColor(.black.opacity(0.8))
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
            .foregroundColor(.white)
            .opacity(compactOpacity)
        }
        .frame(height: headerHeight)
        .animation(.easeInOut(duration: 0.2), value: scrollOffset)
    }
    
    // MARK: - Calculations
    
    private var headerHeight: CGFloat {
        let height = maxHeight + scrollOffset
        return max(minHeight, height)
    }
    
    private var collapseProgress: CGFloat {
        let range = maxHeight - minHeight
        let offset = -scrollOffset
        return min(max(offset / range, 0), 1)
    }
    
    private var largeOpacity: Double {
        Double(1 - collapseProgress)
    }
    
    private var compactOpacity: Double {
        Double(collapseProgress)
    }
}

#Preview {
    FriendsDetailView(
        expenseOverview: Expense(
            memberName: "Preeteesh",
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
            ]
        )
    )
}
