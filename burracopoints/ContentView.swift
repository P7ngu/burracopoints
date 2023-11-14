//
//  ContentView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var gameItems: [Game]
    
    var body: some View {
        NavigationSplitView {
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Game(
                timestamp: Date(), maxPoints: 100, gameMode: 2, playerCounter: 2, squad3Enabled: false, squad1: [Player(name: "Matteo", icon: "person")], squad2: [Player(name: "Nonna", icon: "person")], squad3: [Player(name: "nil", icon: "person")], currentPoints_p1: 0, currentPoints_p2: 0, currentPoints_p3: 0, handPoints_p1: [0], handPoints_p2: [0], handPoints_p3: [0], handsPlayed: 0)
        }
    }
}

   

#Preview {
    ContentView()
        .modelContainer(for: Game.self, inMemory: true)
}
