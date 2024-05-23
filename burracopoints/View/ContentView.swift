//
//  ContentView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import SwiftUI
import SwiftData
import StoreKit




struct ContentView: View {
    @State private var showingSheet = false
    
    @Environment(\.modelContext) var modelContext
    @Query private var gameItems: [Game]
    
    @Query private var players: [Player]
    
    init() {
       self.bestPlayers = getBestPlayers()
       
    }
    
    
   @State private var bestPlayers: [Player] = [Player(name: "nil", icon: "person.fill", currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: 0, numberOfGameWon: 0, winRatio: 1.0, id: -1)]
    
    @State var fulltitle: String = "..."
    
    var body: some View {
        TabView{
            NavigationView {
                VStack{
                    List {
                        ForEach(gameItems.reversed()) { game in //reversed, so the most recent games go on top.
                            NavigationLink {
                                GameDetailedView(displayedGame: game, title: fulltitle)
                            } label: {
                                HStack{
                                    if(!game.isGameConcluded){
                                        // if(game.maxPoints > game.currentPoints_p1 && game.maxPoints > game.currentPoints_p2 && game.maxPoints > game.currentPoints_p3){
                                        Image(systemName: "play.circle") .font(.title2)//.padding(.trailing)
                                    } else {
                                        Image(systemName: "flag.checkered.circle") .font(.title2)//.padding(.trailing)
                                    }
                                    
                                    if(game.squad1.count == 1 && game.squad3.first! == "nil" && game.squad2.count == 1 && game.squad3.count == 1){
                                        //fulltitle = String(game.squad1.first!) + " vs " + String(game.squad2.first!)
                                        
                                        Text(game.squad1.first!)
                                        Text("vs")
                                        Text(game.squad2.first!)
                                         
                                    }
                                    
                                   else if(game.squad3.first! != "nil"){
                                        Text(game.squad1.first!)
                                        Text("vs")
                                        Text(game.squad2.first!)
                                        Text("vs")
                                        Text(game.squad3.first!)
                                    }
                                    else if(game.squad1.count > 1){
                                        HStack{
                                           let fulltitle2 = String(game.squad1.first!) + " & " + String(game.squad1.last!) + " vs " + String(game.squad2.first!) + " & " + String(game.squad2.last!)
                                            Text(String(fulltitle2))
                                            /*
                                            Text(game.squad1.first!)
                                            Text(" && ")
                                            Text(game.squad1.last!)
                                            Text(" vs ")
                                            Text(game.squad2.first!)
                                            Text(" && ")
                                            Text(game.squad2.last!)
                                             */
                                        }
                                            }
                                    
                                    // Text(game))
                                }.padding(.top, 15)
                            } .swipeActions {
                                Button("Delete", systemImage: "trash", role: .destructive) {
                                    modelContext.delete(game)
                                }
                            }
                        } // end for each
                        /*
                        .onDelete { indexSet in
                            gameItems.remove(atOffsets: indexSet)

                        })*/
                    }
                }
                .toolbar {
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        } .sheet(isPresented: $showingSheet) {
                            CreateGameSheetView()
                        }
                    }
                }.navigationTitle("game-title-string")
            }
            .tabItem {
                Label("game-title-string", systemImage: "pencil.and.list.clipboard")
            }
            PlayersView()
                .tabItem{
                    Label ("player-title-string", systemImage: "person.3.fill")
                }
            //Let's pass the best players
            LeaderboardView(bestPlayers: getBestPlayers(), rotation: 0.0)
                .tabItem{
                    Label ("leaderboard-title-string", systemImage: "trophy.fill")
                }
            
        }
        //end of tabview
        .onAppear(perform: {
            resetPlayerSelection()
            if players.count > 1 && gameItems.count > 0 {
                requestReview()
            }
          // bestPlayers = getBestPlayers()
        })
    }
    
    
    public func getBestPlayers() -> [Player]{
        
        if (bestPlayers.first!.name == "nil"){
        
        var nilplayer: Player = Player(name: "nil", icon: "person.fill", currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: -1, numberOfGameWon: -1, winRatio: 0.0, id: -1)
        var maxPlayer = Player(name: "nil", icon: "person.fill", currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: -1, numberOfGameWon: -1, winRatio: 0.0, id: -1)
        var maxPlayer2 = Player(name: "nil", icon: "person.fill", currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: -1, numberOfGameWon: -1, winRatio: 0.0, id: -1)
        var maxPlayer3 = Player(name: "nil", icon: "person.fill", currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: -1, numberOfGameWon: -1, winRatio: 0.0, id: -1)
        
        for player in players{
           
           
            if player.numberOfGameWon > maxPlayer.numberOfGameWon{
                maxPlayer = player
                print("switching player - 1")
            }
        }
        
        for player in players{
           
           
            if player.numberOfGameWon > maxPlayer2.numberOfGameWon && player != maxPlayer{
                maxPlayer2 = player
                print("switching player - 2")
            }
        }
        
        for player in players{
            
            if player.numberOfGameWon > maxPlayer3.numberOfGameWon && player != maxPlayer2 && player != maxPlayer{
                print("true")
                maxPlayer3 = player
            }
        }
        
        print(maxPlayer.name + " " + maxPlayer2.name + " " + maxPlayer3.name + "!")
        if(maxPlayer.name != "nil"){
            return [maxPlayer, maxPlayer2, maxPlayer3]
        }
        
            }else {
           
            return bestPlayers
        }
        return bestPlayers
    }
     
    private func addItem() {
        showingSheet.toggle()
        
        withAnimation {
            // let newItem = Game(timestamp: Date(), maxPoints: 2005, gameMode: 2, playerCounter: 3, squad3Enabled: true, squad1: [player1.name], squad2: [player2.name], squad3: [player3.name], currentPoints_p1: 0, currentPoints_p2: 0, currentPoints_p3: 0, handPoints_p1: [0], handPoints_p2: [0], handPoints_p3: [0], handsPlayed: 0)
            
            //  modelContext.insert(newItem)
        }
        
    }
    
    private func addNewGame(newItem: Game){
        modelContext.insert(newItem)
    }
    
    func requestReview() {
        ReviewRequestManager.shared.requestReviewIfAppropriate()
    }

    
    func resetPlayerSelection(){
        
        for player in players {
            player.currentlySelected1 = false
            player.currentlySelected2 = false
            player.currentlySelected3 = false
        }
    }
    
    
    
    
}



//#Preview {
// ContentView(modelContext: modelContext)
//   .modelContainer(for: [Game.self, Player.self], inMemory: true)
//}
