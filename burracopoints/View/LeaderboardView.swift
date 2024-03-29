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
    @State var trigger = 0
    
    @Environment(\.modelContext) var modelContext
    
    init(bestPlayers: [Player], rotation: CGFloat) {
        self.bestPlayers = bestPlayers
        self.rotation = 0.0
    }
    
    
    var body: some View {
        NavigationView{
            ZStack{
                RoundedRectangle(cornerRadius: 20, style:  .continuous)
                    .frame(width: 270, height: 350)
                    .foregroundColor(Color("L"))
                
                RoundedRectangle(cornerRadius: 20, style:  .continuous)
                    .frame(width: 140, height: 520)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("L"), Color("L")]), startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.degrees(rotation))
                    .mask{
                        RoundedRectangle(cornerRadius: 20, style:  .continuous)
                            .stroke(lineWidth: 12)
                            .frame(width: 266, height: 346)
                    }
                
                VStack{
                    VStack{
                        VStack{
                            Image(systemName: "trophy.circle.fill")
                                .foregroundStyle(Color("T"), Color.yellow)
                                .font(.system(.largeTitle))
                                .symbolEffect(.bounce, value: trigger)
                            if(bestPlayers.count > 1){
                                if bestPlayers.first!.name != "Nil"{
                                    Text(bestPlayers.first!.name).bold().padding()
                                } else {
                                    
                                }
                            }
                        }
                        
                        VStack{
                            Image(systemName: "trophy.circle.fill")
                                .foregroundStyle(Color("T"), Color.gray)
                                .font(.system(.largeTitle))
                            if(bestPlayers.count > 1){
                                Text(bestPlayers[1].name).bold().padding()
                            }
                        }
                        
                        VStack{
                            Image(systemName: "trophy.circle.fill")
                                .foregroundStyle(Color("T"), Color.orange)
                                .font(.system(.largeTitle))
                            if(bestPlayers.count > 2){
                                Text(bestPlayers[2].name).bold().padding()
                            }
                        }//.padding()
                    }
                }
                
            }
            .onAppear(){
            //TODO: test this
              // bestPlayers = ContentView().getBestPlayers()
                trigger += 1
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


