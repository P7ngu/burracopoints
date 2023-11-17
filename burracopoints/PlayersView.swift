//
//  Players.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import SwiftUI
import SwiftData
import Foundation


struct PlayerSheetView: View {
    @State private var playerName: String = ""
    @State private var iconName: String = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var showingAlert = false
    
    var playerItems: [Player]
    
    
    var iconList = [
        Icon(name: "star.circle", id: UUID(), isSelected: false, color: Color.blue), Icon(name: "sun.max.circle", id: UUID(), isSelected: false, color: Color.blue), Icon(name: "person.circle", id: UUID(), isSelected: false, color: Color.blue), Icon(name: "heart.circle", id: UUID(), isSelected: false, color: Color.blue), Icon(name: "moon.circle", id: UUID(), isSelected: false, color: Color.blue), Icon(name: "cloud.circle", id: UUID(), isSelected: false, color: Color.blue), Icon(name: "bolt.circle", id: UUID(), isSelected: false, color: Color.blue)
    ]
    
    var body: some View{
        NavigationView{
            VStack{
                HStack{
                    Text("Name: ").padding()
                    TextField("Player name", text: $playerName).padding()
                }//.padding()
                VStack{
                    Text("Pick an icon: ")
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(iconList){ icon in
                                if(!icon.isSelected){
                                    GroupBox{
                                        Image(systemName: icon.name)
                                            .font(.system(size: 52))
                                            .foregroundColor(icon.color)
                                    }.onTapGesture {
                                            icon.isSelected = true
                                            icon.color = Color.green
                                            print("icon selected")
                                        }
                                }
                                else {
                                    GroupBox{
                                        Image(systemName: icon.name)
                                            .font(.system(size: 52))
                                            .foregroundColor(Color.green)
                                    }.onTapGesture {
                                            icon.isSelected = false
                                            icon.color = Color.blue
                                        }
                                }
                            }
                        }//.padding()
                        
                    }
                }
                
            }
            .navigationBarTitle("Add a new player", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        if(playerName != ""){
                            var newPlayer = Player(name: playerName, icon: iconName, currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: 0, numberOfGameWon: 0, winRatio: 1.0, id: -1)
                            
                            addNewPlayer(player: newPlayer, players: playerItems)
                            dismiss()
                        } else {
                           showingAlert = true
                            showingAlert = true
                           
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            } .alert(isPresented: $showingAlert) {
                Alert(title: Text("Input a name"), message: Text("Please input a name"), dismissButton: .default(Text("Got it!")))
            }
        }
    }
    func addNewPlayer(player: Player, players: [Player]){
            player.id = players.count + 1
            modelContext.insert(player)
        
    }
}


struct PlayersView: View {
    
    @Query private var playerItems: [Player]
    @Environment(\.modelContext) private var modelContext
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView{
            List {
                ForEach(playerItems) { player in
                    NavigationLink {
                        HStack{
                          //  Image(systemName: player.icon)
                            
                            Text(player.name)
                                .padding()
                                .background(.white)
                                .cornerRadius(8)
                            
                            Text(String(player.id))
                                .padding()
                                .background(.white)
                                .cornerRadius(8)
                        }
                    } label: {
                        HStack{
                                Text(player.name)
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(8)
                            
                        }
                    }
                   
                    
                }
                // .onDelete(perform: deleteItems)
                
                
            }
            .toolbar {
               // ToolbarItem(placement: .navigationBarTrailing) {
              //      EditButton()
               // }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    } .sheet(isPresented: $showingSheet) {
                        PlayerSheetView(playerItems: playerItems)
                    }
                    
                }
                
            }  .navigationTitle("Players")
        }
      
    }
    
    
    
    
    
    
    private func addItem() {
        print("adding a new item in players")
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
