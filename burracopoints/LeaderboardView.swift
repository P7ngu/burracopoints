//
//  LeaderboardView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import SwiftUI
import SwiftData

struct LeaderboardView: View {
    
    //@Query var allPlayers: [Player]
    
    @State var bestPlayers: [Player]
    @State var rotation:CGFloat = 0.0
    
    @Environment(\.modelContext) var modelContext
    
    init(bestPlayers: [Player], rotation: CGFloat) {
        self.bestPlayers = bestPlayers
        self.rotation = 0.0
    }
    
    
    var body: some View {
        NavigationView{
            ZStack{
                RoundedRectangle(cornerRadius: 20, style:  .continuous)
                    .frame(width: 260, height: 340)
                    .foregroundColor(Color("L"))
                
                RoundedRectangle(cornerRadius: 20, style:  .continuous)
                    .frame(width: 130, height: 500)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("L"), Color("L")]), startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.degrees(rotation))
                    .mask{
                        RoundedRectangle(cornerRadius: 20, style:  .continuous)
                            .stroke(lineWidth: 12)
                            .frame(width: 256, height: 336)
                    }
                
                VStack{
                    VStack{
                        VStack{
                            Image(systemName: "trophy.circle.fill")
                                .foregroundStyle(Color("T"), Color.yellow)
                                .font(.system(.largeTitle))
                            Text(bestPlayers.first!.name).bold().padding()
                        }
                        
                        VStack{
                            Image(systemName: "trophy.circle.fill")
                                .foregroundStyle(Color("T"), Color.gray)
                                .font(.system(.largeTitle))
                            Text(bestPlayers[1].name).bold().padding()
                        }
                        
                        VStack{
                            Image(systemName: "trophy.circle.fill")
                                .foregroundStyle(Color("T"), Color.orange)
                                .font(.system(.largeTitle))
                            Text(bestPlayers[2].name).bold().padding()
                        }//.padding()
                    }
                }
                
            }
            .onAppear(){
            //TODO: test this
              // bestPlayers = ContentView().getBestPlayers()
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


