//
//  PlayerSheetView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 28/02/24.
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
    
    @State private var selectedIcon: String? = "person.circle"
    
    
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
            ScrollView{
                VStack{
                    HStack{
                        Text("name-string").padding()
                        TextField("player-name-string", text: $playerName).padding()
                    }//.padding()
                    
                    
                    // Spacer()
                    HStack{
                        Text("pickicon-string")
                            .frame(alignment: .leading)
                            .padding()
                        Spacer()
                    }
                    IconSelectionView(selectedIcon: $selectedIcon)
                    
                    Spacer()
                }
                .navigationBarTitle("addnewplayer-string", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Button("done-button-string") {
                            showingAlert_nameuniqueness = false
                            if(playerName != "" && playerName != "Nil"){
                                //chech name uniqueness
                                for player in playerItems {
                                    if player.name == playerName{
                                        showingAlert_nameuniqueness = true
                                        showingAlert = true
                                    }
                                }
                                
                                if(!showingAlert_nameuniqueness){
                                   
                                    let newPlayer = Player(name: playerName, icon: selectedIcon!, currentlySelected1: false, currentlySelected2: false, currentlySelected3: false, numberOfGamePlayed: 0, numberOfGameWon: 0, winRatio: 1.0, id: -1)
                                    
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
