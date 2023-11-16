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
    
    @Environment(\.dismiss) var dismiss
    @Query private var players: [Player]
    @State var oldIcon: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("Game win points: ").padding()
                    TextField("Maximum points", text: $inputMaxPoints).padding()
                }
                HStack{
                    Text("Game mode: ").padding()
                    Picker(selection: $selectedGameMode, label: Text("Game mode: ")) {
                        Text("1 vs 1").tag("1 vs 1")
                        Text("2 vs 2").tag("2 vs 2")
                        Text("1 vs 1 vs 1").tag("1 vs 1 vs 1")
                    }//.pickerStyle(.wheel)
                }
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
                                if(player.currentlySelected1){
                                    player.currentlySelected1 = false
                                }
                                else {
                                    player.currentlySelected1 = true
                                    
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
                                if(player.currentlySelected2){
                                    player.currentlySelected2 = false
                                }
                                else {
                                    player.currentlySelected2 = true
                                    
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
                                        player.currentlySelected3 = false
                                    }
                                    else {
                                        player.currentlySelected3 = true
                                        
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
                        // let newGame = Game(timestamp: Date(), maxPoints: Int(inputMaxPoints), gameMode: Int(gamemode), playerCounter: 2, squad3Enabled: false, squad1: <#T##[Player]#>, squad2: <#T##[Player]#>, squad3: <#T##[Player]#>, currentPoints_p1: <#T##Int#>, currentPoints_p2: <#T##Int#>, currentPoints_p3: <#T##Int#>, handPoints_p1: <#T##[Int]#>, handPoints_p2: <#T##[Int]#>, handPoints_p3: <#T##[Int]#>, handsPlayed: <#T##Int#>)
                        //reset selection
                        resetPlayerSelection()
                        dismiss()
                    }
                }
            }
            
        }
    }
    
    func resetPlayerSelection(){
        for player in players {
            player.currentlySelected1 = false
            player.currentlySelected2 = false
            player.currentlySelected3 = false
        }
    }
}

struct ContentView: View {
    @State private var showingSheet = false
    
    @Environment(\.modelContext) private var modelContext
    @Query private var gameItems: [Game]
    
    var body: some View {
        TabView{
            NavigationView {
                List {
                    ForEach(gameItems) { game in
                        NavigationLink {
                            Text(game.squad1.first!.name)
                        } label: {
                            // Text(game))
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
            
        } //end of tabview
    }
    
    
    
    
    
    private func addItem() {
        showingSheet.toggle()
        print("adding a new item")
        withAnimation {
            //  let newItem = Game(
            //      timestamp: Date(), maxPoints: 100, gameMode: 2, playerCounter: 2, squad3Enabled: false, squad1: [Player(name: "Matteo", icon: "person")], squad2: [Player(name: "Nonna", icon: "person")], squad3: [Player(name: "nil", icon: "person")], currentPoints_p1: 0, currentPoints_p2: 0, currentPoints_p3: 0, handPoints_p1: [0], handPoints_p2: [0], handPoints_p3: [0], handsPlayed: 0)
            
            // modelContext.insert(newItem)
        }
        
    }
}



#Preview {
    ContentView()
        .modelContainer(for: Game.self, inMemory: true)
}
