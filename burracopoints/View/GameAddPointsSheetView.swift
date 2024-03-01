//
//  GameSheetAddPoints.swift
//  burracopoints
//
//  Created by Matteo Perotta on 28/02/24.
//

import SwiftUI
import SwiftData

struct GameAddPointsSheetView: View {
    
    @Bindable var displayedGame: Game
    
    @State private var squad1pointsscore: String = ""
    @State private var squad1pointsbase: String = ""
    @State private var squad2pointsscore: String = ""
    @State private var squad2pointsbase: String = ""
    @State private var squad3pointsscore: String = ""
    @State private var squad3pointsbase: String = ""
    
    @State var winner: String = ""
    
    @Environment(\.modelContext) var modelContext
    
    @Query var players: [Player]
    
    @Environment(\.dismiss) var dismiss
    var count = 0
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    if(displayedGame.isGameConcluded == true){
                        VStack{
                            Text("gameoveradd-string").bold()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    else{
                        //We need at least 2 input boxes, 3 maximum
                        if displayedGame.gameMode == 2 {
                            // 1 vs 1
                            VStack{
                                VStack{
                                    //player 1 points
                                    GroupBox{
                                        Text(displayedGame.squad1.first!)
                                        TextField("base-string", text: $squad1pointsbase)
                                            .padding().keyboardType(.numberPad)
                                        TextField("score-string", text: $squad1pointsscore)
                                            .padding().keyboardType(.numberPad)
                                    }
                                }.padding()
                                VStack{
                                    GroupBox{
                                        //player 2 points
                                        Text(displayedGame.squad2.first!)
                                        TextField("base-string", text: $squad2pointsbase)
                                            .padding().keyboardType(.numberPad)
                                        TextField("score-string", text: $squad2pointsscore)
                                            .padding().keyboardType(.numberPad)
                                    }
                                }.padding()
                            }
                            
                        } else if displayedGame.gameMode == 3 {
                            // 1 vs 1 vs 1, 3 boxes
                            VStack{
                                VStack{
                                    //player 1 points
                                    GroupBox{
                                        Text(displayedGame.squad1.first!)
                                        TextField("base-string", text: $squad1pointsbase)
                                            .padding().keyboardType(.numberPad)
                                        TextField("score-string", text: $squad1pointsscore)
                                            .padding().keyboardType(.numberPad)
                                    }
                                }.padding()
                                
                                VStack{
                                    GroupBox{
                                        //player 2 points
                                        Text(displayedGame.squad2.first!)
                                        TextField("base-string", text: $squad2pointsbase)
                                            .padding().keyboardType(.numberPad)
                                        TextField("score-string", text: $squad2pointsscore)
                                            .padding().keyboardType(.numberPad)
                                    }
                                }.padding()
                                
                                VStack{
                                    GroupBox{
                                        //player 3 points
                                        Text(displayedGame.squad3.first!)
                                        TextField("base-string", text: $squad3pointsbase)
                                            .padding().keyboardType(.numberPad)
                                        TextField("score-string", text: $squad3pointsscore)
                                            .padding().keyboardType(.numberPad)
                                    }
                                }.padding()
                            }
                            
                        } else if displayedGame.gameMode == 4 {
                            
                            //2 vs 2, 2x2 boxes
                            VStack{
                                VStack{
                                    //player 1 points
                                    GroupBox{
                                        Text(displayedGame.squad1.first! + " & " + displayedGame.squad1[1])
                                        TextField("base-string", text: $squad1pointsbase)
                                            .padding().keyboardType(.numberPad)
                                        TextField("score-string", text: $squad1pointsscore)
                                            .padding().keyboardType(.numberPad)
                                    }
                                }.padding()
                                
                                VStack{
                                    GroupBox{
                                        //player 2 points
                                        Text(displayedGame.squad2.first! + " & " + displayedGame.squad2[1])
                                        TextField("base-string", text: $squad2pointsbase)
                                            .padding().keyboardType(.numberPad)
                                        TextField("score-string", text: $squad2pointsscore)
                                            .padding().keyboardType(.numberPad)
                                    }
                                }.padding()
                            }
                        }
                        
                        
                    }
                }
                .navigationBarTitle("addpoints-string", displayMode: .inline)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("done-button-string") {
                        //Add points and then dismiss
                        //TODO: check the input
                        if displayedGame.isGameConcluded{
                            
                            Text("gameoveradd-string")
                            dismiss()
                            GameDetailedView(displayedGame: displayedGame, title: "")
                            
                        } else{
                            if squad1pointsbase == "" {
                                squad1pointsbase = "0"
                            }
                            if squad2pointsbase == "" {
                                squad2pointsbase = "0"
                            }
                            if squad1pointsscore == "" {
                                squad1pointsscore = "0"
                            }
                            if squad2pointsscore == "" {
                                squad2pointsscore = "0"
                            }
                            
                            if displayedGame.squad3Enabled {
                                if squad3pointsbase == "" {
                                    squad3pointsbase = "0"
                                }
                                if squad3pointsscore == "" {
                                    squad3pointsscore = "0"
                                }
                                displayedGame.currentPoints_p1 += Int(squad1pointsbase)! + Int(squad1pointsscore)!
                                displayedGame.currentPoints_p2 += Int(squad2pointsbase)! + Int(squad2pointsscore)!
                                displayedGame.currentPoints_p3 += Int(squad3pointsbase)! + Int(squad3pointsscore)!
                                
                                if( max(displayedGame.currentPoints_p1, displayedGame.currentPoints_p2, displayedGame.currentPoints_p3) > displayedGame.maxPoints){
                                    displayedGame.isGameConcluded = true
                                    //let's save our winner
                                    if (displayedGame.currentPoints_p1 > displayedGame.currentPoints_p2 && displayedGame.currentPoints_p1 > displayedGame.currentPoints_p3){
                                        //player 1 is the winner
                                        
                                        let winner = displayedGame.squad1.first!
                                        let loser1 = displayedGame.squad2.first!
                                        let loser2 = displayedGame.squad3.first!
                                        //we need the player name to be unique at this point, or switch to id for every check
                                        giveTheUserAWin(game: displayedGame, username: winner)
                                        giveTheUserALoss(game: displayedGame, username: loser1)
                                        giveTheUserALoss(game: displayedGame, username: loser2)
                                        //done. if the game is finished do not let the user add other points and change the interface accordingly.
                                    } else if(displayedGame.currentPoints_p2 > displayedGame.currentPoints_p1 && displayedGame.currentPoints_p2 > displayedGame.currentPoints_p3){
                                        let winner = displayedGame.squad2.first!
                                        let loser1 = displayedGame.squad1.first!
                                        let loser2 = displayedGame.squad3.first!
                                        //we need the player name to be unique at this point, or switch to id for every check
                                        giveTheUserAWin(game: displayedGame, username: winner)
                                        giveTheUserALoss(game: displayedGame, username: loser1)
                                        giveTheUserALoss(game: displayedGame, username: loser2)
                                    } else if(displayedGame.currentPoints_p3 > displayedGame.currentPoints_p1 && displayedGame.currentPoints_p3 > displayedGame.currentPoints_p2){
                                        let winner = displayedGame.squad3.first!
                                        let loser1 = displayedGame.squad1.first!
                                        let loser2 = displayedGame.squad2.first!
                                        //we need the player name to be unique at this point, or switch to id for every check
                                        giveTheUserAWin(game: displayedGame, username: winner)
                                        giveTheUserALoss(game: displayedGame, username: loser1)
                                        giveTheUserALoss(game: displayedGame, username: loser2)
                                        
                                        //TODO: pareggio, the most unlikely thing to happen so all good for now, right me of the future?
                                    }
                                    
                                } else {
                                    
                                }
                                
                                _ = displayedGame.handPoints_p1.count
                                
                                displayedGame.handPoints_p1.append( Int( Int(squad1pointsbase)! + Int(squad1pointsscore)! ) )
                                displayedGame.handPoints_p2.append( Int( Int(squad2pointsbase)! + Int(squad2pointsscore)! ) )
                                displayedGame.handPoints_p3.append( Int( Int(squad3pointsbase)! + Int(squad3pointsscore)! ) )
                                
                                dismiss()
                                GameDetailedView(displayedGame: displayedGame, title: "")
                            } else {
                                print(squad1pointsbase + "  -  " + squad2pointsbase)
                                print(squad1pointsscore + "  -  " + squad2pointsscore)
                                
                                displayedGame.currentPoints_p1 += Int(squad1pointsbase)! + Int(squad1pointsscore)!
                                displayedGame.currentPoints_p2 += Int(squad2pointsbase)! + Int(squad2pointsscore)!
                                
                                if( max(displayedGame.currentPoints_p1, displayedGame.currentPoints_p2) > displayedGame.maxPoints){
                                    //TODO: add here
                                    displayedGame.isGameConcluded = true
                                    //let's save our winner
                                    if (displayedGame.currentPoints_p1 > displayedGame.currentPoints_p2){
                                        //player 1 is the winner
                                        let winner = displayedGame.squad1.first!
                                        let loser1 = displayedGame.squad2.first!
                                        //we need the player name to be unique at this point, or switch to id for every check
                                        giveTheUserAWin(game: displayedGame, username: winner)
                                        giveTheUserALoss(game: displayedGame, username: loser1)
                                        
                                        if displayedGame.gameMode == 4 {
                                            let winner2 = displayedGame.squad1[1]
                                            let loser3 = displayedGame.squad2[1]
                                            giveTheUserAWin(game: displayedGame, username: winner2)
                                            giveTheUserALoss(game: displayedGame, username: loser3)
                                        }
                                        
                                    } else if(displayedGame.currentPoints_p2 > displayedGame.currentPoints_p1){
                                        let winner = displayedGame.squad2.first!
                                        let loser1 = displayedGame.squad1.first!
                                        
                                        //we need the player name to be unique at this point, or switch to id for every check
                                        giveTheUserAWin(game: displayedGame, username: winner)
                                        giveTheUserALoss(game: displayedGame, username: loser1)
                                        
                                        if displayedGame.gameMode == 4 {
                                            let winner2 = displayedGame.squad2[1]
                                            let loser3 = displayedGame.squad1[1]
                                            giveTheUserAWin(game: displayedGame, username: winner2)
                                            giveTheUserALoss(game: displayedGame, username: loser3)
                                        }
                                        
                                    }
                                    
                                    
                                    
                                } else {
                                    
                                }
                                
                                _ = displayedGame.handPoints_p1.count
                                
                                
                                displayedGame.handPoints_p1.append( Int( Int(squad1pointsbase)! + Int(squad1pointsscore)! ))
                                displayedGame.handPoints_p2.append( Int( Int(squad2pointsbase)! + Int(squad2pointsscore)! ))
                                dismiss()
                                GameDetailedView(displayedGame: displayedGame, title: "")
                            }
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel-button-string") {
                        squad1pointsbase = "0"
                        squad1pointsscore = "0"
                        squad2pointsbase = "0"
                        squad2pointsscore = "0"
                        squad3pointsbase = "0"
                        squad3pointsscore = "0"
                        dismiss()
                        GameDetailedView(displayedGame: displayedGame, title: "")
                    }
                }
            }
            
        }
    }
    
    func giveTheUserAWin(game: Game, username: String){
        
        for player in players {
            print(player.name)
            if player.name == username{
                
                player.numberOfGameWon += 1
                player.numberOfGamePlayed += 1
            }
            
        }
    }
    
    func giveTheUserALoss(game: Game, username: String){
        for player in players {
            if player.name == username{
                player.numberOfGamePlayed += 1
            }
            
        }
        
    }
}
