//
//  ContentView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import SwiftUI
import SwiftData


//Shet view to create a new game
struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
        Text("Hello World")
        .font(.title)
        .padding()
            
            
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
            
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
