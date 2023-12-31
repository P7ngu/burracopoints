//
//  GameDetailedView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 16/11/23.
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
                                        .padding().keyboardType(.decimalPad)
                                    TextField("score-string", text: $squad1pointsscore)
                                        .padding().keyboardType(.decimalPad)
                                }
                            }.padding()
                            VStack{
                                GroupBox{
                                    //player 2 points
                                    Text(displayedGame.squad2.first!)
                                    TextField("base-string", text: $squad2pointsbase)
                                        .padding().keyboardType(.decimalPad)
                                    TextField("score-string", text: $squad2pointsscore)
                                        .padding().keyboardType(.decimalPad)
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
                                        .padding().keyboardType(.decimalPad)
                                    TextField("score-string", text: $squad1pointsscore)
                                        .padding().keyboardType(.decimalPad)
                                }
                            }.padding()
                            
                            VStack{
                                GroupBox{
                                    //player 2 points
                                    Text(displayedGame.squad2.first!)
                                    TextField("base-string", text: $squad2pointsbase)
                                        .padding().keyboardType(.decimalPad)
                                    TextField("score-string", text: $squad2pointsscore)
                                        .padding().keyboardType(.decimalPad)
                                }
                            }.padding()
                            
                            VStack{
                                GroupBox{
                                    //player 2 points
                                    Text(displayedGame.squad3.first!)
                                    TextField("base-string", text: $squad3pointsbase)
                                        .padding().keyboardType(.decimalPad)
                                    TextField("score-string", text: $squad3pointsscore)
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
                                    TextField("base-string", text: $squad1pointsbase)
                                        .padding().keyboardType(.decimalPad)
                                    TextField("score-string", text: $squad1pointsscore)
                                        .padding().keyboardType(.decimalPad)
                                }
                            }.padding()
                            
                            VStack{
                                GroupBox{
                                    //player 2 points
                                    Text(displayedGame.squad2.first! + " & " + displayedGame.squad2[1])
                                    TextField("base-string", text: $squad2pointsbase)
                                        .padding().keyboardType(.decimalPad)
                                    TextField("score-string", text: $squad2pointsscore)
                                        .padding().keyboardType(.decimalPad)
                                }
                            }.padding()
                        }
                    }
                    
                    
                }
            }
            .navigationBarTitle("addpoints-string", displayMode: .inline)
            
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
                                        
                                        var winner = displayedGame.squad1.first!
                                        var loser1 = displayedGame.squad2.first!
                                        var loser2 = displayedGame.squad3.first!
                                        //we need the player name to be unique at this point, or switch to id for every check
                                        giveTheUserAWin(game: displayedGame, username: winner)
                                        giveTheUserALoss(game: displayedGame, username: loser1)
                                        giveTheUserALoss(game: displayedGame, username: loser2)
                                        //done. if the game is finished do not let the user add other points and change the interface accordingly.
                                    } else if(displayedGame.currentPoints_p2 > displayedGame.currentPoints_p1 && displayedGame.currentPoints_p2 > displayedGame.currentPoints_p3){
                                        var winner = displayedGame.squad2.first!
                                        var loser1 = displayedGame.squad1.first!
                                        var loser2 = displayedGame.squad3.first!
                                        //we need the player name to be unique at this point, or switch to id for every check
                                        giveTheUserAWin(game: displayedGame, username: winner)
                                        giveTheUserALoss(game: displayedGame, username: loser1)
                                        giveTheUserALoss(game: displayedGame, username: loser2)
                                    } else if(displayedGame.currentPoints_p3 > displayedGame.currentPoints_p1 && displayedGame.currentPoints_p3 > displayedGame.currentPoints_p2){
                                        var winner = displayedGame.squad3.first!
                                        var loser1 = displayedGame.squad1.first!
                                        var loser2 = displayedGame.squad2.first!
                                        //we need the player name to be unique at this point, or switch to id for every check
                                        giveTheUserAWin(game: displayedGame, username: winner)
                                        giveTheUserALoss(game: displayedGame, username: loser1)
                                        giveTheUserALoss(game: displayedGame, username: loser2)
                                        
                                        //TODO: pareggio, the most unlikely thing to happen so all good for now, right me of the future?
                                    }
                                    
                                } else {
                                    
                                }
                                
                                var currentHand = displayedGame.handPoints_p1.count
                                
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
                                        var winner = displayedGame.squad1.first!
                                        var loser1 = displayedGame.squad2.first!
                                        //we need the player name to be unique at this point, or switch to id for every check
                                        giveTheUserAWin(game: displayedGame, username: winner)
                                        giveTheUserALoss(game: displayedGame, username: loser1)
                                        
                                        if displayedGame.gameMode == 4 {
                                            var winner2 = displayedGame.squad1[1]
                                            var loser3 = displayedGame.squad2[1]
                                            giveTheUserAWin(game: displayedGame, username: winner2)
                                            giveTheUserALoss(game: displayedGame, username: loser3)
                                        }
                                        
                                    } else if(displayedGame.currentPoints_p2 > displayedGame.currentPoints_p1){
                                        var winner = displayedGame.squad2.first!
                                        var loser1 = displayedGame.squad1.first!
                                        
                                        //we need the player name to be unique at this point, or switch to id for every check
                                        giveTheUserAWin(game: displayedGame, username: winner)
                                        giveTheUserALoss(game: displayedGame, username: loser1)
                                        
                                        if displayedGame.gameMode == 4 {
                                            var winner2 = displayedGame.squad2[1]
                                            var loser3 = displayedGame.squad1[1]
                                            giveTheUserAWin(game: displayedGame, username: winner2)
                                            giveTheUserALoss(game: displayedGame, username: loser3)
                                        }
                                        
                                    }
                                    
                                    
                                    
                                } else {
                                    
                                }
                                
                                var currentHand = displayedGame.handPoints_p1.count
                                
                                
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





struct GameDetailedView: View {
    @State private var showingAlert = false
    @Bindable var displayedGame: Game
    @State var title: String
    @State private var showingSheet = false
    @State private var selectedDealer = "None"
    
    @State var trigger = 0
    var body: some View {
        // NavigationView{
        ScrollView{
            VStack{
                
                if(displayedGame.isGameConcluded == true){
                    VStack{
                        Text("gameover-string").bold().font(.title3)
                        Image(systemName: "flag.checkered.2.crossed").bold()
                            .symbolEffect(.bounce, value: trigger)
                            .font(.largeTitle)
                            .onTapGesture(perform: {
                                trigger = trigger + 1
                            })
                    }
                } //else if(displayedGame.handPoints_p1.count < 2)
                
                
                
                if displayedGame.gameMode == 2 {
                    
                    if(displayedGame.firstDealer == "None"){
                        GroupBox{
                            Text("dealer-string")
                            Picker(selection: $selectedDealer, label: Text("dealer-string")) {
                                Text("None").tag("None")
                                Text(displayedGame.squad1.first!).tag(displayedGame.squad1.first!)
                                Text(displayedGame.squad2.first!).tag(displayedGame.squad2.first!)
                                //TODO: use the actual data
                            } .onChange(of: selectedDealer){
                                if(selectedDealer != "None"){
                                    displayedGame.firstDealer = selectedDealer}
                            }
                        }
                        
                    }
                    
                    
                    HStack{
                        GroupBox{
                            VStack{
                                HStack{
                                    Text(displayedGame.squad1.first!).bold()
                                    if(displayedGame.firstDealer == displayedGame.squad1.first! ){
                                        Text(" *").bold().foregroundStyle(Color("AccentColor1"))
                                    }
                                }
                                HStack{
                                    Text("points-section-string")
                                    Text(String(displayedGame.currentPoints_p1))
                                }.padding()
                                
                                ForEach(1..<displayedGame.handPoints_p1.count, id: \.self){ index in
                                    HStack{
                                        Text("hand-string")
                                        Text(String(index) + ":")
                                        Text(String(displayedGame.handPoints_p1[index]))
                                        
                                    }
                                }
                            }
                        }
                        GroupBox{
                            VStack{
                                HStack{
                                    Text(displayedGame.squad2.first!).bold()
                                    if(displayedGame.firstDealer == displayedGame.squad2.first! ){
                                        Text(" *").bold().foregroundStyle(Color("AccentColor1"))
                                    }
                                }
                                HStack{
                                    Text("points-section-string")
                                    Text(String(displayedGame.currentPoints_p2))
                                }.padding()
                                
                                
                                ForEach(1..<displayedGame.handPoints_p2.count, id: \.self){ index in
                                    HStack{
                                        Text("hand-string")
                                        Text(String(index) + ":")
                                        Text(String(displayedGame.handPoints_p2[index]))
                                    }
                                }
                            }
                        }
                    }
                    
                    
                } else if displayedGame.gameMode == 3 {
                    if(displayedGame.firstDealer == "None"){
                        GroupBox{
                            Text("dealer-string")
                            Picker(selection: $selectedDealer, label: Text("dealer-string")) {
                                Text("None").tag("None")
                                Text(displayedGame.squad1.first!).tag(displayedGame.squad1.first!)
                                Text(displayedGame.squad2.first!).tag(displayedGame.squad2.first!)
                                Text(displayedGame.squad3.first!).tag(displayedGame.squad3.first!)
                                //TODO: use the actual data
                            }
                        }
                    }
                    
                    // 1 vs 1 vs 1, 3 boxes
                    VStack{
                        VStack{
                            //player 1 points
                            GroupBox{
                                VStack{
                                    Text(displayedGame.squad1.first!)
                                    HStack{
                                        Text("points-section-string")
                                        Text(String(displayedGame.currentPoints_p1))
                                    }
                                    ForEach(1..<displayedGame.handPoints_p1.count, id: \.self){ index in
                                        HStack{
                                            Text("hand-string")
                                            Text(String(index) + ":")
                                            Text(String(displayedGame.handPoints_p1[index]))
                                        }
                                    }
                                }
                                //.frame(minWidth: 500)
                            }
                        }
                        
                        VStack{
                            GroupBox{
                                //player 2 points
                                Text(displayedGame.squad2.first!)
                                HStack{
                                    Text("points-section-string")
                                    
                                    Text(String(displayedGame.currentPoints_p2))
                                }
                                ForEach(1..<displayedGame.handPoints_p2.count, id: \.self){ index in
                                    HStack{
                                        Text("hand-string")
                                        Text(String(index) + ":")
                                        Text(String(displayedGame.handPoints_p2[index]))
                                    }
                                }
                                .frame(minWidth: 500)
                            }
                        }
                        
                        VStack{
                            GroupBox{
                                //player 3 points
                                Text(displayedGame.squad3.first!)
                                HStack{
                                    Text("points-section-string")
                                    Text(String(displayedGame.currentPoints_p3))
                                }
                                ForEach(1..<displayedGame.handPoints_p3.count, id: \.self){ index in
                                    HStack{
                                        Text("hand-string")
                                        Text(String(index) + ":")
                                        Text(String(displayedGame.handPoints_p3[index]))
                                    }
                                }
                                .frame(minWidth: 500)
                            }
                        }
                    }
                } else if displayedGame.gameMode == 4 {
                    if(displayedGame.firstDealer == "None"){
                        GroupBox{
                            Text("dealer-string")
                            Picker(selection: $selectedDealer, label: Text("dealer-string")) {
                                Text("None").tag("None")
                                Text(displayedGame.squad1.first!).tag(displayedGame.squad1.first!)
                                Text(displayedGame.squad1[1]).tag(displayedGame.squad1[1])
                                Text(displayedGame.squad2.first!).tag(displayedGame.squad2.first!)
                                Text(displayedGame.squad2[1]).tag(displayedGame.squad2[1])
                                //TODO: use the actual data
                            }
                        }
                    }
                    
                    //2 vs 2, 2x2 boxes
                    HStack{
                        VStack{
                            //player 1 points
                            GroupBox{
                                Text(displayedGame.squad1.first! + " & " + displayedGame.squad1[1])
                                Text(String(displayedGame.currentPoints_p1))
                                ForEach(1..<displayedGame.handPoints_p1.count, id: \.self){ index in
                                    Text("hand-string")
                                    Text(String(index) + ":")
                                    Text(String(displayedGame.handPoints_p1[index]))
                                }
                            }
                        }
                        VStack{
                            GroupBox{
                                //player 2 points
                                Text(displayedGame.squad2.first! + " & " + displayedGame.squad2[1])
                                Text(String(displayedGame.currentPoints_p2))
                                ForEach(1..<displayedGame.handPoints_p2.count, id: \.self){ index in
                                    Text("hand-string")
                                    Text(String(index) + ":")
                                    Text(String(displayedGame.handPoints_p2[index]))
                                    
                                }
                            }//.padding()
                        }
                    }
                    
                    
                    
                    
                }
                // } //end of vstack
                
                
                
            }
        }.scrollIndicators(.hidden)//.frame(minWidth: 500 )
            .onAppear(){
                print(displayedGame.firstDealer)
                trigger += 1
                if(displayedGame.squad3.first! != "nil"){
                    title = displayedGame.squad1.first! + " vs " + displayedGame.squad2.first! + " vs " + displayedGame.squad3.first!
                } else {
                    title = displayedGame.squad1.first! + " vs " + displayedGame.squad2.first!
                }
            }
        
        //}
            .navigationTitle(title)
            .toolbar {
               
                ToolbarItem{
                    
                    Button("Undo") {
                        showingAlert = true
                    }
                    .alert(isPresented:$showingAlert) {
                        Alert(
                            title: Text("Are you sure you want to undo the last insertion?"),
                            message: Text("There is no way back"),
                            primaryButton: .destructive(Text("Confirm")) {
                                if(displayedGame.handPoints_p1.count > 1 && displayedGame.handPoints_p2.count > 1){
                                    //displayedGame.handsPlayed = displayedGame.handsPlayed-1
                                    displayedGame.handPoints_p1.remove(at: displayedGame.handPoints_p1.count - 1)
                                    displayedGame.handPoints_p2.remove(at: displayedGame.handPoints_p2.count - 1)
                                    
                                    if(displayedGame.squad3Enabled){
                                        displayedGame.handPoints_p3.remove(at: displayedGame.handPoints_p3.count - 1)
                                    }
                                }
                               
                                print("Deleting...")
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    
                    
                }
                
                ToolbarItem {
                    Button(action: addPoints) {
                        Label("addpoints-string", systemImage: "note.text.badge.plus")
                    } .sheet(isPresented: $showingSheet) {
                        // displayedGame.firstDealer = selectedDealer
                        GameAddPointsSheetView(displayedGame: displayedGame)
                    }
                }
               
            }
        
    }
    
    
    
    //end view
    
    func undoPoints(){
       showingAlert = true
    }
    
    
    func addPoints(){
        // displayedGame.firstDealer = selectedDealer
        showingSheet = true
        
    }
}


//#Preview {
// GameDetailedView(displayedGame: Game(timestamp: Date(), maxPoints: 2005, gameMode: 2, playerCounter: 2, squad3Enabled: false, squad1: ["Matteo"], squad2: ["Nonna"], squad3: ["nil"], currentPoints_p1: 500, currentPoints_p2: 340, currentPoints_p3: 0, handPoints_p1: [500], handPoints_p2: [340], handPoints_p3: [0], handsPlayed: 1))
// GameDetailedView()
//}


