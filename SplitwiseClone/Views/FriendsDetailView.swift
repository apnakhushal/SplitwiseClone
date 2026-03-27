//
//  FriendsDetailView.swift
//  SplitwiseClone
//
//  Created by Khushal on 01/03/2026.
//

import SwiftUI

struct FriendsDetailView: View {

    @Environment(\.dismiss) private var dismiss
    
    private let maxHeight: CGFloat = 260
    private let minHeight: CGFloat = 90
    
    @State private var scrollOffset: CGFloat = 0
    
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
                    
                    // Content
                    VStack(spacing: 16) {
                        ForEach(0..<25) { i in
                            row(index: i)
                        }
                    }
                    .padding()
                }
            }
            .coordinateSpace(name: "scroll")
            
            header
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
                        colors: [Color.green, Color.blue],
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
                    }
                    Spacer()
                }
                .padding(.leading)
                .foregroundColor(.white)
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .foregroundColor(.white)
                    .opacity(largeOpacity)
                
                VStack(spacing: 4) {
                    Text("John Doe")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    
                    Text("You owe ₹2,450")
                        .foregroundColor(.white.opacity(0.9))
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
                }
                Spacer()
                Text("John Doe")
                    .font(.headline)
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
    
    // MARK: - Row
    
    private func row(index: Int) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Dinner \(index)")
                    .font(.headline)
                Text("Paid by Alex")
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("₹\(index * 120)")
                .font(.headline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    FriendsDetailView()
}
