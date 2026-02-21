//
//  DashboardFriendsView.swift
//  SplitwiseClone
//
//  Created by apple on 18.01.26.
//

import SwiftUI

struct DashboardFriendsView: View {
    var body: some View {
        TabView {
            FriendsExpensesView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Friends")
                }
            
            Text("Groups")
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Groups")
                }
            
            Text("Activity")
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Activity")
                }
            
            Text("Account")
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Account")
                }
        }
    }
}

#Preview {
    DashboardFriendsView()
}
