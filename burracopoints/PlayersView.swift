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
    @State private var showingAlert_nameuniqueness = false
    
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
                        showingAlert_nameuniqueness = false
                        if(playerName != ""){
                            //chech name uniqueness
                          
                            ForEach(iconList){ icon in
                                if icon.isSelected == true {
                                  //  iconName = icon.name
                                } else {
                                    
                                }
                            }
                            for player in playerItems {
                                if player.name == playerName{
                                    showingAlert_nameuniqueness = true
                                    showingAlert = true
                                }
                            }
                            
                            if(!showingAlert_nameuniqueness){
                                let newPlayer = Player(name: playerName, icon: iconName, currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: 0, numberOfGameWon: 0, winRatio: 1.0, id: -1)
                                
                                addNewPlayer(player: newPlayer, players: playerItems)
                                dismiss()
                            }
                        } else {
                           showingAlert = true
                           
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel-button-string") {
                        dismiss()
                    }
                }
            } 
            
            .alert(isPresented: $showingAlert) {
                if(showingAlert_nameuniqueness){
                    Alert(title: Text("errorinputname2-string"), message: Text("errordetailinputname2-string"), dismissButton: .default(Text("okbuttonerror-string")))
                } else{
                    Alert(title: Text("errorinputname-string"), message: Text("errordetailinputname-string"), dismissButton: .default(Text("okbuttonerror-string")))
                }
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
                        VStack{
                            
                            Image(systemName: player.icon).font(.system(size: 70))
                            HStack{
                                Text(player.name).font(.title)
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
