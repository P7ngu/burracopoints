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
    @Environment(\.dismiss) var dismiss
    
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
                                    Image(systemName: icon.name)
                                        .font(.system(size: 52))
                                        .foregroundColor(icon.color)
                                        .onTapGesture {
                                            icon.isSelected = true
                                            icon.color = Color.green
                                            print("icon selected")
                                        }
                                }
                                else {
                                    Image(systemName: icon.name)
                                        .font(.system(size: 52))
                                        .foregroundColor(Color.green)
                                        .onTapGesture {
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
                        dismiss()
                    }
                }
            }
        }
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
                    HStack{
                        Image(systemName: player.icon)
                        
                        Text(player.name)
                            .padding()
                            .background(.white)
                            .cornerRadius(8)
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
                    } .sheet(isPresented: $showingSheet) {
                        PlayerSheetView()
                    }
                }
            }
            .navigationTitle("Players")
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


#Preview {
    PlayersView()
}
