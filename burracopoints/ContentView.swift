//
//  ContentView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import SwiftUI
import SwiftData

//Sheet view to create a new game
struct SheetView: View {
    @State private var inputMaxPoints: String = ""
    @State private var selectedGameMode = "1 vs 1"
    @State private var showingPlayerSheet = false
    @Environment(\.modelContext) var modelContext
    
    @State private var currentPlayersT1 = 0
    @State private var currentPlayersT2 = 0
    @State private var currentPlayersT3 = 0
    
    @State private var maximumPlayersT1 = 1
    @State private var maximumPlayersT2 = 1
    @State private var maximumPlayersT3 = 1
    
    @State private var nilplayer: Player = Player(name: "nil", icon: "person.fill", currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: 0, numberOfGameWon: 0, winRatio: 1.0, id: -1)
    @State private var player1: Player = Player(name: "nil", icon: "person.fill", currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: 0, numberOfGameWon: 0, winRatio: 1.0, id: -1)
    @State private var player2: Player = Player(name: "nil", icon: "person.fill", currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: 0, numberOfGameWon: 0, winRatio: 1.0, id: -1)
    @State private var player3: Player = Player(name: "nil", icon: "person.fill", currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: 0, numberOfGameWon: 0, winRatio: 1.0, id: -1)
    @State private var player4: Player = Player(name: "nil", icon: "person.fill", currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: 0, numberOfGameWon: 0, winRatio: 1.0, id: -1)
    
    @Environment(\.dismiss) var dismiss
    @Query private var players: [Player]
    @State var oldIcon: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                VStack{
                    Image(systemName: "trophy.circle")
                        .font(.system(size: 72))
                        .foregroundColor(Color.green)
                    
                    HStack{
                        Text("Game mode: ").padding()
                        Picker(selection: $selectedGameMode, label: Text("Game mode: ")) {
                            Text("1 vs 1").tag("1 vs 1")
                            Text("2 vs 2").tag("2 vs 2")
                            Text("1 vs 1 vs 1").tag("1 vs 1 vs 1")
                        }//.pickerStyle(.wheel)
                    }
                    HStack{
                        Text("Game win points: ").padding()
                        TextField("Maximum points", text: $inputMaxPoints).padding().keyboardType(.decimalPad)
                    }.padding()
                    
                    //Add button to create a new player
                    Button(action: {
                        setPlayerAmountBasedOnGamemode()
                        showingPlayerSheet.toggle()
                    }, label: {
                        Text("Create a new player")
                            .padding()
                    }).sheet(isPresented: $showingPlayerSheet) {
                        PlayerSheetView(playerItems: players)
                    }.padding()
                    
                    Text("Select players for team 1: ")
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(players){ player in
                                GroupBox{
                                    VStack{
                                        if(!player.currentlySelected1){
                                            Image(systemName: player.icon)
                                            Text(player.name)
                                                .padding()
                                                .background(.white)
                                                .cornerRadius(8)
                                        } else { //player selected already
                                            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                            Text(player.name)
                                                .padding()
                                                .background(.white)
                                                .cornerRadius(8)
                                        }
                                    }
                                }.onTapGesture{
                                    setPlayerAmountBasedOnGamemode()
                                    //TODO: add if to support the 2vs2
                                    if(selectedGameMode == "1 vs 1"){
                                        if(player.currentlySelected1){
                                            currentPlayersT1 = currentPlayersT1 - 1
                                            player.currentlySelected1 = false
                                            player1 = nilplayer
                                            print("deselec. currently selected players:")
                                            print(currentPlayersT1)
                                        }
                                        else if (maximumPlayersT1 > currentPlayersT1){
                                            setPlayerAmountBasedOnGamemode()
                                            currentPlayersT1 = currentPlayersT1 + 1
                                            player.currentlySelected1 = true
                                            print("selecting. currently selected players:")
                                            print(currentPlayersT1)
                                            player1 = player
                                            
                                        }
                                    } else if(selectedGameMode == "2 vs 2"){
                                        print("TEST")
                                        //TODO: test
                                        if(player.currentlySelected1){
                                            currentPlayersT1 = currentPlayersT1 - 1
                                            player.currentlySelected1 = false
                                            player1 = nilplayer
                                            print("deselec. currently selected players:")
                                            print(currentPlayersT1)
                                        }
                                        else if (maximumPlayersT1 > currentPlayersT1){
                                            print("Entering else if")
                                            setPlayerAmountBasedOnGamemode()
                                            currentPlayersT1 = currentPlayersT1 + 1
                                            player.currentlySelected1 = true
                                            print("selecting. currently selected players:")
                                            print(currentPlayersT1)
                                            
                                            if(player1.name == "nil"){
                                                player1 = player
                                            } else {
                                                player2 = player
                                            }
                                            
                                        }
                                    }
                                    
                                }
                            }
                        }
                        .padding()
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    
                    Text("Select players for team 2: ")
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(players){ player in
                                GroupBox{
                                    VStack{
                                        if(!player.currentlySelected2){
                                            Image(systemName: player.icon)
                                            Text(player.name)
                                                .padding()
                                                .background(.white)
                                                .cornerRadius(8)
                                        } else {
                                            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                            Text(player.name)
                                                .padding()
                                                .background(.white)
                                                .cornerRadius(8)
                                        }
                                    }
                                }.onTapGesture{
                                    if(selectedGameMode == "1 vs 1"){
                                        if(player.currentlySelected2){
                                            print("des. currently selected players:")
                                            setPlayerAmountBasedOnGamemode()
                                            currentPlayersT2 = currentPlayersT2 - 1
                                            print(String(currentPlayersT2) + player.name)
                                            player.currentlySelected2 = false
                                            player2 = nilplayer
                                        }
                                        else if (maximumPlayersT2 > currentPlayersT2){
                                            print("selec. currently selected players:")
                                            setPlayerAmountBasedOnGamemode()
                                            currentPlayersT2 = currentPlayersT2 + 1
                                            print(String(currentPlayersT2) + player.name)
                                            player.currentlySelected2 = true
                                            player2 = player
                                            
                                        }
                                    }
                                    else if(selectedGameMode == "2 vs 2"){
                                        print("TEST 2")
                                        //TODO: test
                                        if(player.currentlySelected2){
                                            currentPlayersT2 = currentPlayersT2 - 1
                                            player.currentlySelected2 = false
                                            if(player3.name == player.name){
                                                player3 = nilplayer
                                            } else {
                                                player4 =  nilplayer
                                            }
                                            print("deselec. currently selected players:")
                                            print(currentPlayersT2)
                                        }
                                        else if (maximumPlayersT2 > currentPlayersT2){
                                            print("Entering else if 2")
                                            setPlayerAmountBasedOnGamemode()
                                            currentPlayersT2 = currentPlayersT2 + 1
                                            player.currentlySelected2 = true
                                            print("selecting. currently selected players:")
                                            print(currentPlayersT2)
                                            
                                            if(player3.name == "nil"){
                                                print("player 3 nil")
                                                player3 = player
                                            } else {
                                                print("saving player 4")
                                                player4 = player
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    if (selectedGameMode == "1 vs 1 vs 1"){
                        Text("Select players for team 3: ")
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(players){ player in
                                    GroupBox{
                                        VStack{
                                            if(!player.currentlySelected3){
                                                Image(systemName: player.icon)
                                                Text(player.name)
                                                    .padding()
                                                    .background(.white)
                                                    .cornerRadius(8)
                                            } else {
                                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                                Text(player.name)
                                                    .padding()
                                                    .background(.white)
                                                    .cornerRadius(8)
                                            }
                                        }
                                    }.onTapGesture{
                                        if(player.currentlySelected3){
                                            setPlayerAmountBasedOnGamemode()
                                            currentPlayersT3 = currentPlayersT3 + 1
                                            player.currentlySelected3 = false
                                            player3 = nilplayer
                                        }
                                        else if (maximumPlayersT3 > currentPlayersT3){
                                            setPlayerAmountBasedOnGamemode()
                                            currentPlayersT3 = currentPlayersT3 + 1
                                            player.currentlySelected3 = true
                                            player3 = player
                                            
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        .background(Color(UIColor.systemGroupedBackground))
                    } else {
                        
                    }
                }
                .navigationBarTitle("Create a new game", displayMode: .inline)
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            //Create the new game
                            let gamemode = selectedGameMode
                            let timestamp = Date()
                            let maxPoints = Int(inputMaxPoints)
                            var playerCounter = 0
                            
                            if (selectedGameMode == "1 vs 1 vs 1" && player1.name != "nil" &&  player2.name != "nil" &&  player3.name != "nil"){
                                print("valid data1")
                                playerCounter = 3
                                let squad3Enabled = true
                                let squad1 = [player1.name]
                                let squad2 = [player2.name]
                                let squad3 = [player3.name]
                                resetPlayerSelection()
                                dismiss()
                            } else if (selectedGameMode == "2 vs 2" && player1.name != "nil" &&  player2.name != "nil" && player3.name != "nil" &&  player4.name != "nil" ){
                                print("valid data2")
                                playerCounter = 4
                                let squad3Enabled = false
                                let squad1 = [player1.name, player2.name]
                                let squad2 = [player3.name, player4.name]
                                resetPlayerSelection()
                                
                                var newGame = Game(timestamp: Date(), maxPoints: Int(maxPoints!), gameMode: 4, playerCounter: playerCounter, squad3Enabled: squad3Enabled, squad1: squad1, squad2: squad2, squad3: ["nil"], currentPoints_p1: 0, currentPoints_p2: 0, currentPoints_p3: 0, handPoints_p1: [0], handPoints_p2: [0], handPoints_p3: [0], handsPlayed: 0, isGameConcluded: false)
                                addNewGame(newItem: newGame)
                                dismiss()
                                
                            } else if(selectedGameMode == "1 vs 1" && player1.name != "nil" && player2.name != "nil"){
                                // 1 vs 1
                                print("valid data3")
                                playerCounter = 2
                                let squad3Enabled = false
                                let squad1 = [player1.name]
                                let squad2 = [player2.name]
                                resetPlayerSelection()
                                var newGame = Game(timestamp: Date(), maxPoints: Int(maxPoints!), gameMode: 2, playerCounter: playerCounter, squad3Enabled: squad3Enabled, squad1: squad1, squad2: squad2, squad3: ["nil"], currentPoints_p1: 0, currentPoints_p2: 0, currentPoints_p3: 0, handPoints_p1: [0], handPoints_p2: [0], handPoints_p3: [0], handsPlayed: 0, isGameConcluded: false)
                                addNewGame(newItem: newGame)
                                dismiss()
                                
                            } else{
                                print("invalid data - last else")
                                print(selectedGameMode)
                                print(player1.name)
                                print(player2.name)
                                print(player3.name)
                                print(player4.name)
                                
                                showingAlert = true
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            resetPlayerSelection()
                            dismiss()
                        }
                    }
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text("Select all the players"), message: Text("Please select all the players"), dismissButton: .default(Text("Got it!")))
                }
            }
        }
    }
    private func addNewGame(newItem: Game){
        modelContext.insert(newItem)
    }
    
    func resetPlayerSelection(){
        for player in players {
            player.currentlySelected1 = false
            player.currentlySelected2 = false
            player.currentlySelected3 = false
        }
    }
    
    func setPlayerAmountBasedOnGamemode(){
        if (selectedGameMode == "1 vs 1 vs 1"){
            maximumPlayersT1 = 1
            maximumPlayersT2 = 1
            maximumPlayersT3 = 1
        } else if (selectedGameMode == "2 vs 2"){
            maximumPlayersT1 = 2
            maximumPlayersT2 = 2
            maximumPlayersT3 = 0
        } else {
            maximumPlayersT1 = 1
            maximumPlayersT2 = 1
            maximumPlayersT3 = 0
        }
    }
}

struct ContentView: View {
    @State private var showingSheet = false
    
    @Environment(\.modelContext) var modelContext
    @Query private var gameItems: [Game]
    @Query private var players: [Player]
    
    var body: some View {
        TabView{
            NavigationView {
                List {
                    ForEach(gameItems) { game in
                        NavigationLink {
                            GameDetailedView(displayedGame: game, title: game.squad1.first! + " vs " + game.squad2.first!)
                        } label: {
                            HStack{
                                if(!game.isGameConcluded){
                                    // if(game.maxPoints > game.currentPoints_p1 && game.maxPoints > game.currentPoints_p2 && game.maxPoints > game.currentPoints_p3){
                                    Image(systemName: "play.circle")
                                } else {
                                    Image(systemName: "flag.checkered.circle")
                                }
                                Text(game.squad1.first!)
                                Text(" vs ")
                                Text(game.squad2.first!)
                                // Text(game))
                            }
                        }
                    }
                    // .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        } .sheet(isPresented: $showingSheet) {
                            SheetView()
                        }
                    }
                }.navigationTitle("Games")
            }
            .tabItem {
                Label("Games", systemImage: "pencil.and.list.clipboard")
            }
            PlayersView()
                .tabItem{
                    Label ("Players", systemImage: "person.3.fill")
                }
            LeaderboardView()
                .tabItem{
                    Label ("Leaderboard", systemImage: "trophy.fill")
                }
            
        }
        //end of tabview
        .onAppear(perform: {
            resetPlayerSelection()
        })
    }
    
    
    
    
    
    private func addItem() {
        showingSheet.toggle()
        print("adding a new item")
        withAnimation {
            // let newItem = Game(timestamp: Date(), maxPoints: 2005, gameMode: 2, playerCounter: 3, squad3Enabled: true, squad1: [player1.name], squad2: [player2.name], squad3: [player3.name], currentPoints_p1: 0, currentPoints_p2: 0, currentPoints_p3: 0, handPoints_p1: [0], handPoints_p2: [0], handPoints_p3: [0], handsPlayed: 0)
            
            //  modelContext.insert(newItem)
        }
        
    }
    
    private func addNewGame(newItem: Game){
        modelContext.insert(newItem)
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
