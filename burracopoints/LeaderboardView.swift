//
//  LeaderboardView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        NavigationView{
       // Text("hello-string")
            Text("hello-string2 \("Matteo")")
         .navigationTitle("leaderboard-title-string")
        }//.navigationTitle("Leaderboard")
    }
}

#Preview {
    LeaderboardView()
}
