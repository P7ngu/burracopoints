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
    @State private var showingSheet = false
    @State var trigger = 0
    
    
    
    var body: some View {
        
        NavigationView{
                
                List {
                    Button(action: {
                        showingSheet = true
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("addnewplayer-string")
                        }
                    }
                    .buttonStyle(.borderless)
                    
                    ForEach(playerItems) { player in
                        
                        NavigationLink {
                            VStack{
                                
                                Image(systemName: player.icon)
                                    .font(.system(size: 100))
                                    .symbolEffect(.bounce, value: trigger)
                                    .onTapGesture {
                                        trigger = trigger + 1
                                    }
                                HStack{
                                    Text(player.name).font(.title).bold()
                                        .padding()
                                        .cornerRadius(8)
                                    
                                    
                                    // Text(String(player.id))
                                }
                                HStack{
                                    Text("winplayer-string")
                                    Text(String(player.numberOfGameWon))
                                }
                                HStack{
                                    Text("gamesplayed-string")
                                    Text(String(player.numberOfGamePlayed))
                                }
                            }
                        } label: {
                            
                            HStack{
                                if player.icon != ""{
                                    Image(systemName: player.icon)
                                        .font(.title2)
                                } else {
                                    Image(systemName: "person.fill")
                                }
                                
                                Text(player.name)
                                    .padding()
                                    .cornerRadius(8)
                                
                            }
                        } .swipeActions {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                modelContext.delete(player)
                            }
                        }
                        
                        
                    }
                    .id(UUID())
                    // .onDelete(perform: deleteItems)
                    
                    
                }
            
            .toolbar {
                // ToolbarItem(placement: .navigationBarTrailing) {
                //      EditButton()
                // }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add a new player", systemImage: "plus")
                    } .sheet(isPresented: $showingSheet) {
                        PlayerSheetView(playerItems: playerItems)
                    }
                    
                }
                
            }  .navigationTitle("player-title-string")
        }
        
        
    }
    
    
    
    
    
    private func addItem() {
        
        showingSheet.toggle()
        withAnimation {
            // let newItem = Player(name: "Matteo", icon: "person.fill", currentlySelected1: false, currentlySelected2: false, currentlySelected3: false)
            //   modelContext.insert(newItem)
        }
    }
}



//#Preview {
// PlayersView()
//}
