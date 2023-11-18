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
    
    @State var colorState = Color.blue
    
    var playerItems: [Player]
    
    
    var iconList = [
        Icon(name: "star.circle", id: UUID(), isSelected: false, color: Color.blue), Icon(name: "sun.max.circle", id: UUID(), isSelected: false, color: Color.blue), Icon(name: "person.circle", id: UUID(), isSelected: false, color: Color.blue), Icon(name: "heart.circle", id: UUID(), isSelected: false, color: Color.blue), Icon(name: "moon.circle", id: UUID(), isSelected: false, color: Color.blue), Icon(name: "cloud.circle", id: UUID(), isSelected: false, color: Color.blue), Icon(name: "bolt.circle", id: UUID(), isSelected: false, color: Color.blue)
    ]
    
    var body: some View{
        NavigationView{
            VStack{
                GroupBox{
                    Text("selectedicon-string")
                    if(iconName == ""){
                        Image(systemName: "x.circle")
                            .font(.system(size: 52))
                            .padding()
                    } else {
                        Image(systemName: iconName)
                            .font(.system(size: 52))
                            .padding()
                    }
                }
                
                HStack{
                    Text("name-string").padding()
                    TextField("player-name-string", text: $playerName).padding()
                }//.padding()
                
               
                    Text("pickicon-string")
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
                                            iconName = icon.name
                                            colorState = Color.green
                                            icon.color = colorState
                                            print("icon selected")
                                        }
                                }
                                else {
                                    GroupBox{
                                        Image(systemName: icon.name)
                                            .font(.system(size: 52))
                                            .foregroundColor(icon.color)
                                    }.onTapGesture {
                                            icon.isSelected = false
                                        colorState = Color.blue
                                        icon.color = colorState
                                           
                                        }
                                }
                            }
                        //.padding()
                        
                    }
                }
                
            }
            .navigationBarTitle("addnewplayer-string", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("done-button-string") {
                        if(playerName != ""){
                            ForEach(iconList){ icon in
                                if icon.isSelected == true {
                                  //  iconName = icon.name
                                } else {
                                    
                                }
                            }
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
                    Button("cancel-button-string") {
                        dismiss()
                    }
                }
            } .alert(isPresented: $showingAlert) {
                Alert(title: Text("errorinputname-string"), message: Text("errordetailinputname-string"), dismissButton: .default(Text("okbuttonerror-string")))
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
                          Image(systemName: player.icon)
                            
                            Text(player.name)
                                .padding()
                                .cornerRadius(8)
                            
                            Text(String(player.id))
                                .padding()
                                .cornerRadius(8)
                        }
                    } label: {
                        HStack{
                            Image(systemName: player.icon)
                            
                                Text(player.name)
                                    .padding()
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
                
            }  .navigationTitle("player-title-string")
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
