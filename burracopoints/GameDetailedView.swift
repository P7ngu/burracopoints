//
//  GameDetailedView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 16/11/23.
//

import SwiftUI

struct GameAddPointsSheetView: View {
    
    @Bindable var displayedGame: Game
    
    @State private var squad1pointsscore: String = ""
    @State private var squad1pointsbase: String = ""
    @State private var squad2pointsscore: String = ""
    @State private var squad2pointsbase: String = ""
    @State private var squad3pointsscore: String = ""
    @State private var squad3pointsbase: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            VStack{
               //We need at least 2 input boxes, 3 maximum
                if displayedGame.gameMode == 2 { 
                    // 1 vs 1
                    HStack{
                        VStack{
                            //player 1 points
                            GroupBox{
                                Text(displayedGame.squad1.first!)
                                TextField("Base", text: $squad1pointsbase)
                                    .padding().keyboardType(.decimalPad)
                                TextField("Score", text: $squad1pointsscore)
                                    .padding().keyboardType(.decimalPad)
                            }
                        }.padding()
                        
                        VStack{
                            GroupBox{
                                //player 2 points
                                Text(displayedGame.squad2.first!)
                                TextField("Base", text: $squad2pointsbase)
                                    .padding().keyboardType(.decimalPad)
                                TextField("Score", text: $squad2pointsscore)
                                    .padding().keyboardType(.decimalPad)
                            }
                        }.padding()
                    }
                    
                } else if displayedGame.gameMode == 3 {
                    // 1 vs 1 vs 1, 3 boxes
                    HStack{
                        VStack{
                            //player 1 points
                            GroupBox{
                                Text(displayedGame.squad1.first!)
                                TextField("Base", text: $squad1pointsbase)
                                    .padding().keyboardType(.decimalPad)
                                TextField("Score", text: $squad1pointsscore)
                                    .padding().keyboardType(.decimalPad)
                            }
                        }.padding()
                        
                        VStack{
                            GroupBox{
                                //player 2 points
                                Text(displayedGame.squad2.first!)
                                TextField("Base", text: $squad2pointsbase)
                                    .padding().keyboardType(.decimalPad)
                                TextField("Score", text: $squad2pointsscore)
                                    .padding().keyboardType(.decimalPad)
                            }
                        }.padding()
                        
                        VStack{
                            GroupBox{
                                //player 2 points
                                Text(displayedGame.squad3.first!)
                                TextField("Base", text: $squad3pointsbase)
                                    .padding().keyboardType(.decimalPad)
                                TextField("Score", text: $squad3pointsscore)
                                    .padding().keyboardType(.decimalPad)
                            }
                        }.padding()
                    }
                    
                } else if displayedGame.gameMode == 4 {
                    //2 vs 2, 2x2 boxes
                    HStack{
                        VStack{
                            //player 1 points
                            GroupBox{
                                Text(displayedGame.squad1.first! + " & " + displayedGame.squad1[1])
                                TextField("Base", text: $squad1pointsbase)
                                    .padding().keyboardType(.decimalPad)
                                TextField("Score", text: $squad1pointsscore)
                                    .padding().keyboardType(.decimalPad)
                            }
                        }.padding()
                        
                        VStack{
                            GroupBox{
                                //player 2 points
                                Text(displayedGame.squad2.first! + " & " + displayedGame.squad2[1])
                                TextField("Base", text: $squad2pointsbase)
                                    .padding().keyboardType(.decimalPad)
                                TextField("Score", text: $squad2pointsscore)
                                    .padding().keyboardType(.decimalPad)
                            }
                        }.padding()
                    }
                }
                    
                
            }
            .navigationBarTitle("Add points", displayMode: .inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        //Add points and then dismiss
                        //TODO: check the input
                        if displayedGame.squad3Enabled {
                            displayedGame.currentPoints_p1 += Int(squad1pointsbase)! + Int(squad1pointsscore)!
                            displayedGame.currentPoints_p2 += Int(squad2pointsbase)! + Int(squad2pointsscore)!
                            displayedGame.currentPoints_p3 += Int(squad3pointsbase)! + Int(squad3pointsscore)!
                            
                            if( max(displayedGame.currentPoints_p1, displayedGame.currentPoints_p2, displayedGame.currentPoints_p3) > displayedGame.maxPoints){
                                displayedGame.isGameConcluded = true
                            } else {
                                
                            }
                            
                            var currentHand = displayedGame.handPoints_p1.count
                            
                            displayedGame.handPoints_p1[currentHand] = Int(squad1pointsbase)! + Int(squad1pointsscore)!
                            displayedGame.handPoints_p2[currentHand] = Int(squad2pointsbase)! + Int(squad2pointsscore)!
                            displayedGame.handPoints_p3[currentHand] = Int(squad3pointsbase)! + Int(squad3pointsscore)!
                            
                            dismiss()
                        } else {
                            print(squad1pointsbase + "  -  " + squad2pointsbase)
                            print(squad1pointsscore + "  -  " + squad2pointsscore)
                            
                            displayedGame.currentPoints_p1 += Int(squad1pointsbase)! + Int(squad1pointsscore)!
                            displayedGame.currentPoints_p2 += Int(squad2pointsbase)! + Int(squad2pointsscore)!
                            
                            if( max(displayedGame.currentPoints_p1, displayedGame.currentPoints_p2) > displayedGame.maxPoints){
                                displayedGame.isGameConcluded = true
                                print("the game is concluded")
                            } else {
                                
                            }
                            
                            var currentHand = displayedGame.handPoints_p1.count
                            
                           
                            displayedGame.handPoints_p1.append( Int( Int(squad1pointsbase)! + Int(squad1pointsscore)! ))
                            displayedGame.handPoints_p2.append( Int( Int(squad2pointsbase)! + Int(squad2pointsscore)! ))
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        squad1pointsbase = "0"
                        squad1pointsscore = "0"
                        squad2pointsbase = "0"
                        squad2pointsscore = "0"
                        squad3pointsbase = "0"
                        squad3pointsscore = "0"
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
                if displayedGame.gameMode == 2 {
                    HStack{
                        GroupBox{
                            VStack{
                                Text(displayedGame.squad1.first!).bold()
                                HStack{
                                    Text("Points: ")
                                    Text(String(displayedGame.currentPoints_p1))
                                }
                                
                                ForEach(0..<displayedGame.handPoints_p1.count, id: \.self){ index in
                                    HStack{
                                        Text("Hand " + String(index) + ":")
                                        Text(String(displayedGame.handPoints_p1[index]))
                                    }
                                }
                            }
                        }
                        GroupBox{
                            VStack{
                                Text(displayedGame.squad2.first!).bold()
                                HStack{
                                    Text("Points: ")
                                    Text(String(displayedGame.currentPoints_p2))
                                }
                                ForEach(0..<displayedGame.handPoints_p2.count, id: \.self){ index in
                                    HStack{
                                        Text("Hand " + String(index) + ":")
                                        Text(String(displayedGame.handPoints_p2[index]))
                                    }
                                }
                            }
                        }
                    }
                    
                   
                } else if displayedGame.gameMode == 3 {
                    // 1 vs 1 vs 1, 3 boxes
                    HStack{
                        VStack{
                            //player 1 points
                            GroupBox{
                                VStack{
                                    Text(displayedGame.squad1.first!)
                                    Text(String(displayedGame.currentPoints_p1))
                                    ForEach(0..<displayedGame.handPoints_p1.count, id: \.self){ index in
                                        Text("Hand " + String(index) + ":")
                                        Text(String(displayedGame.handPoints_p1[index]))
                                    }
                                }
                                
                            }
                        }.padding()
                        
                        VStack{
                            GroupBox{
                                //player 2 points
                                Text(displayedGame.squad2.first!)
                                Text(String(displayedGame.currentPoints_p2))
                                ForEach(0..<displayedGame.handPoints_p2.count, id: \.self){ index in
                                    Text("Hand " + String(index) + ":")
                                    Text(String(displayedGame.handPoints_p2[index]))
                                }
                            }
                        }.padding()
                        
                        VStack{
                            GroupBox{
                                //player 3 points
                                Text(displayedGame.squad3.first!)
                                Text(String(displayedGame.currentPoints_p3))
                                ForEach(0..<displayedGame.handPoints_p3.count, id: \.self){ index in
                                    Text("Hand " + String(index) + ":")
                                    Text(String(displayedGame.handPoints_p3[index]))
                                }
                            }
                        }.padding()
                    }
                } else if displayedGame.gameMode == 4 {
                    //2 vs 2, 2x2 boxes
                    HStack{
                        VStack{
                            //player 1 points
                            GroupBox{
                                Text(displayedGame.squad1.first! + " & " + displayedGame.squad1[1])
                                Text(String(displayedGame.currentPoints_p1))
                                ForEach(0..<displayedGame.handPoints_p1.count, id: \.self){ index in
                                    Text("Hand " + String(index) + ":")
                                    Text(String(displayedGame.handPoints_p1[index]))
                                }
                            }
                        }.padding()
                        VStack{
                            GroupBox{
                                //player 2 points
                                Text(displayedGame.squad2.first! + " & " + displayedGame.squad2[1])
                                Text(String(displayedGame.currentPoints_p2))
                                ForEach(0..<displayedGame.handPoints_p2.count, id: \.self){ index in
                                    Text("Hand " + String(index) + ":")
                                    Text(String(displayedGame.handPoints_p2[index]))
                                }
                            }
                        }.padding()
                    }
                }
                
                
            }
        } .toolbar {
            ToolbarItem {
                Button(action: addPoints) {
                    Label("Add Points", systemImage: "note.text.badge.plus")
                } .sheet(isPresented: $showingSheet) {
                    GameAddPointsSheetView(displayedGame: displayedGame)
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
