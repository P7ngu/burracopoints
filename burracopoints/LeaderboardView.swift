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
                    .foregroundColor(Color.green)
                
                RoundedRectangle(cornerRadius: 20, style:  .continuous)
                    .frame(width: 130, height: 500)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.yellow]), startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.degrees(rotation))
                    .mask{
                        RoundedRectangle(cornerRadius: 20, style:  .continuous)
                            .stroke(lineWidth: 7)
                            .frame(width: 256, height: 336)
                    }
                
                VStack{
                    Image(systemName: "trophy.circle.fill")
                        .foregroundColor(Color.yellow)
                        .font(.system(size: 40))
                        //.withAnimation(SwiftUI.Animation?, <#T##() -> Result#>)
                    Text(bestPlayers.first!.name).bold()
                    
                    VStack{
                        Image(systemName: "trophy.circle.fill")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 35))
                        Text(bestPlayers[1].name).bold().padding()
                        Image(systemName: "trophy.circle.fill")
                            .foregroundColor(Color.orange)
                            .font(.system(size: 30))
                        Text(bestPlayers[2].name).bold().padding()
                    }.padding()
                }
                
            }
            .onAppear(){
                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)){
                    rotation = 360
                }
            } .navigationTitle("leaderboard-title-string")
       // Text("hello-string")
           
         //.navigationTitle("leaderboard-title-string")
        }//.navigationTitle("Leaderboard")
        //.navigationTitle("leaderboard-title-string")
    }
}


