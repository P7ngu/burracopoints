//
//  Players.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import SwiftUI
import SwiftData
import Foundation

struct PlayersView: View {
    @Query private var playerItems: [Player]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView{
            List {
                ForEach(playerItems) { player in
                    NavigationLink {
                        Text("hi")
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
            .navigationTitle("Players")
        }
        
    }
    private func addItem() {
        print("adding a new item")
        withAnimation {
            let newItem = Player(name: "Matteo", icon: "person")
            modelContext.insert(newItem)
        }
    }
}


#Preview {
    PlayersView()
}
