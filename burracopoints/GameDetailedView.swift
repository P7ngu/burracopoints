//
//  GameDetailedView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 16/11/23.
//

import SwiftUI

struct GameAddPointsSheetView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            VStack{
                
                
            }
            .navigationBarTitle("Add points", displayMode: .inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        //Add points and then dismiss
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            
        }
    }
}

struct GameDetailedView: View {
    @Bindable var displayedGame: Game
    @State var title: String
    @State private var showingSheet = false
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    
                }
                
            }
        } .toolbar {
            ToolbarItem {
                Button(action: addPoints) {
                    Label("Add Points", systemImage: "note.text.badge.plus")
                } .sheet(isPresented: $showingSheet) {
                    GameAddPointsSheetView()
                }
            }
        }.navigationTitle(title)
            .onAppear(){
                title = displayedGame.squad1.first! + " vs " + displayedGame.squad2.first!
            }
    }
    
    func addPoints(){
        showingSheet = true
        
    }
}

//#Preview {
   // GameDetailedView(displayedGame: Game(timestamp: Date(), maxPoints: 2005, gameMode: 2, playerCounter: 2, squad3Enabled: false, squad1: ["Matteo"], squad2: ["Nonna"], squad3: ["nil"], currentPoints_p1: 500, currentPoints_p2: 340, currentPoints_p3: 0, handPoints_p1: [500], handPoints_p2: [340], handPoints_p3: [0], handsPlayed: 1))
   // GameDetailedView()
//}
