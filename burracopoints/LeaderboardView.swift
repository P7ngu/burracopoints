//
//  LeaderboardView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import SwiftUI

struct LeaderboardView: View {
    
    var bestPlayers: [Player] = [Player(name: "nil", icon: "person.fill", currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: 0, numberOfGameWon: 0, winRatio: 1.0, id: -1)]
    @State var rotation:CGFloat = 0.0
    
    init(bestPlayers: [Player], rotation: CGFloat) {
        self.bestPlayers = bestPlayers
        self.rotation = 0.0
    }
    
    
    var body: some View {
        NavigationView{
            ZStack{
                RoundedRectangle(cornerRadius: 20, style:  .continuous)
                    .frame(width: 260, height: 340)
                    .foregroundColor(Color.blue)
                
                RoundedRectangle(cornerRadius: 20, style:  .continuous)
                    .frame(width: 130, height: 500)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.yellow]), startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.degrees(rotation))
                    .mask{
                        RoundedRectangle(cornerRadius: 20, style:  .continuous)
                            .stroke(lineWidth: 7)
                            .frame(width: 256, height: 336)
                    }
                
               Text(bestPlayers.first!.name).bold()
                
            }
            .onAppear(){
                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)){
                    rotation = 360
                }
            }
       // Text("hello-string")
            Text("hello-string2 \("Matteo")")
         .navigationTitle("leaderboard-title-string")
        }//.navigationTitle("Leaderboard")
    }
}


