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
        Icon(name: "star.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "sun.max.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "person.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "heart.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "moon.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "cloud.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "bolt.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "snowflake.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "flame.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "theatermasks.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "popcorn.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "tortoise.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "lizard.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "bird.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "fish.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "tennisball.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "wind.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "toilet.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "sailboat.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "airplane.circle", id: UUID(), isSelected: false, color: Color.blue),
        Icon(name: "leaf.circle", id: UUID(), isSelected: false, color: Color.blue)
        
       
    ]
    
    var body: some View{
        NavigationView{
            VStack{
                Image(systemName: "person.crop.circle.badge.plus")
                    .font(.system(size: 80))
              
                
                HStack{
                    Text("name-string").padding()
                    TextField("player-name-string", text: $playerName).padding()
                }//.padding()
                
               // Spacer()
                
                Text("pickicon-string")
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(iconList){ icon in
                                if(!icon.isSelected){
                                    GroupBox{
                                        Image(systemName: icon.name)
                                            .font(.largeTitle)                                            //.foregroundColor(icon.color)
                                    }.onTapGesture {
                                        if(!icon.isSelected){
                                            icon.isSelected = true
                                            if(icon.isSelected){
                                                print ("hello1")
                                            } else{
                                                
                                            }
                                            iconName = icon.name
                                            colorState = Color.green
                                            icon.color = colorState
                                            print("icon selected")
                                        } else if(icon.isSelected){
                                            icon.isSelected = false
                                            iconName = icon.name
                                            colorState = Color.blue
                                            icon.color = colorState
                                            print("icon unselected")
                                        }
                                        }
                                }
                                else {
                                   // print("hi there")
                                    GroupBox{
                                        //Image(systemName: icon.name)
                                        //    .font(.system(size: 52))
                                         //   .foregroundColor(colorState)
                                    }
                                }
                            }
                        //.padding()
                        
                    } .frame(height: 150, alignment: .topLeading)
                    }.scrollIndicators(.hidden)
                
                GroupBox{
                   // Spacer()
                    Text("selectedicon-string")
                    if(iconName == ""){
                        Image(systemName: "x.circle")
                            .font(.largeTitle)
                            .padding()
                    } else {
                        Image(systemName: iconName)
                            .font(.title)
                            .padding()
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
    @State var trigger = 0
    
   
    
    var body: some View {
        
        NavigationView{
            List {
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
