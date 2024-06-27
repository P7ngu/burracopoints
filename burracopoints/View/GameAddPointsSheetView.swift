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
    
    @State var isSoloSelected = false
    @State var isPlayerOneSolo = false
    @State var isPlayerTwoSolo = false
    @State var isPlayerThreeSolo = false
    
    @State var winner: String = ""
    @State private var text: String = ""
    
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
                        // print(displayedGame.squad1.first!)
                        //We need at least 2 input boxes, 3 maximum
                        if displayedGame.gameMode == 2 {
                            // 1 vs 1
                            VStack{
                                VStack{
                                    //player 1 points
                                    GroupBox{
                                        Text(displayedGame.squad1.first!)
                                        TextField("base-string", text: $squad1pointsbase)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad1pointsbase) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad1pointsbase = filteredString
                                            }
                                        
                                        TextField("score-string", text: $squad1pointsscore)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad1pointsscore) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad1pointsscore = filteredString
                                            }
                                    }
                                }.padding()
                                VStack{
                                    GroupBox{
                                        //player 2 points
                                        Text(displayedGame.squad2.first!)
                                        TextField("base-string", text: $squad2pointsbase)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad2pointsbase) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad2pointsbase = filteredString
                                            }
                                        
                                        TextField("score-string", text: $squad2pointsscore)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad2pointsscore) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad2pointsscore = filteredString
                                            }
                                    }
                                }.padding()
                            }
                            
                        } else if displayedGame.gameMode == 3 {
                            //MARK: 1 vs 1 vs 1
                            //TODO: split points mode
                            if(isSoloSelected == false){
                                VStack{
                                    VStack{
                                        //player 1 points
                                        HStack{
                                            Spacer()
                                            if(!isSoloSelected){
                                                Button("mark-solo"){
                                                    isSoloSelected = true
                                                    isPlayerOneSolo = true
                                                }
                                            } else {
                                                Button("Unmark as solo"){
                                                    isSoloSelected = false
                                                    isPlayerOneSolo = false
                                                    
                                                }
                                                
                                            }
                                        }
                                        GroupBox{
                                            Text(displayedGame.squad1.first!)
                                            TextField("base-string", text: $squad1pointsbase)
                                                .padding().keyboardType(.numbersAndPunctuation)
                                                .onChange(of: squad1pointsbase) { newValue in
                                                    var filteredString = ""
                                                    for (index, character) in newValue.enumerated() {
                                                        if index == 0 && character == "-" {
                                                            filteredString.append(character)
                                                        }
                                                        else if character.isNumber {
                                                            filteredString.append(character)
                                                        }
                                                    }
                                                    squad1pointsbase = filteredString
                                                }
                                            
                                            TextField("score-string", text: $squad1pointsscore)
                                                .padding().keyboardType(.numbersAndPunctuation)
                                                .onChange(of: squad1pointsscore) { newValue in
                                                    var filteredString = ""
                                                    for (index, character) in newValue.enumerated() {
                                                        if index == 0 && character == "-" {
                                                            filteredString.append(character)
                                                        }
                                                        else if character.isNumber {
                                                            filteredString.append(character)
                                                        }
                                                    }
                                                    squad1pointsscore = filteredString
                                                }
                                        }
                                    }.padding()
                                    
                                    VStack{
                                        HStack{
                                            Spacer()
                                            Button("mark-solo"){
                                                isSoloSelected = true
                                                isPlayerTwoSolo = true
                                            }
                                        }
                                        GroupBox{
                                            //player 2 points
                                            Text(displayedGame.squad2.first!)
                                            TextField("base-string", text: $squad2pointsbase)
                                                .padding().keyboardType(.numbersAndPunctuation)
                                                .onChange(of: squad2pointsbase) { newValue in
                                                    var filteredString = ""
                                                    for (index, character) in newValue.enumerated() {
                                                        if index == 0 && character == "-" {
                                                            filteredString.append(character)
                                                        }
                                                        else if character.isNumber {
                                                            filteredString.append(character)
                                                        }
                                                    }
                                                    squad2pointsbase = filteredString
                                                }
                                            
                                            TextField("score-string", text: $squad2pointsscore)
                                                .padding().keyboardType(.numbersAndPunctuation)
                                                .onChange(of: squad2pointsscore) { newValue in
                                                    var filteredString = ""
                                                    for (index, character) in newValue.enumerated() {
                                                        if index == 0 && character == "-" {
                                                            filteredString.append(character)
                                                        }
                                                        else if character.isNumber {
                                                            filteredString.append(character)
                                                        }
                                                    }
                                                    squad2pointsscore = filteredString
                                                }
                                        }
                                    }.padding()
                                    
                                    VStack{
                                        
                                        GroupBox{
                                            //player 3 points
                                            HStack{
                                                Spacer()
                                                Button("mark-solo"){
                                                    isSoloSelected = true
                                                    isPlayerThreeSolo = true
                                                }
                                            }
                                            Text(displayedGame.squad3.first!)
                                            TextField("base-string", text: $squad3pointsbase)
                                                .padding().keyboardType(.numbersAndPunctuation)
                                                .onChange(of: squad3pointsbase) { newValue in
                                                    var filteredString = ""
                                                    for (index, character) in newValue.enumerated() {
                                                        if index == 0 && character == "-" {
                                                            filteredString.append(character)
                                                        }
                                                        else if character.isNumber {
                                                            filteredString.append(character)
                                                        }
                                                    }
                                                    squad3pointsbase = filteredString
                                                }
                                            
                                            TextField("score-string", text: $squad3pointsscore)
                                                .padding().keyboardType(.numbersAndPunctuation)
                                                .onChange(of: squad3pointsscore) { newValue in
                                                    var filteredString = ""
                                                    for (index, character) in newValue.enumerated() {
                                                        if index == 0 && character == "-" {
                                                            filteredString.append(character)
                                                        }
                                                        else if character.isNumber {
                                                            filteredString.append(character)
                                                        }
                                                    }
                                                    squad3pointsscore = filteredString
                                                }
                                        }
                                    }.padding()
                                }
                            } else {
                                //MARK: Solo is selected, adjust interface
                                //First the solo, with an unmkark as solo button, and a check for that
                                if(isPlayerOneSolo){
                                    //MARK: Player One Solo Points
                                    GroupBox{
                                        HStack {
                                            Spacer()
                                            Spacer()
                                            Text(displayedGame.squad1.first!)
                                            Spacer()
                                            Button("unmark-text"){
                                                isPlayerOneSolo = false
                                                isSoloSelected = false
                                            }
                                        }
                                        TextField("base-string", text: $squad1pointsbase)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad1pointsbase) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad1pointsbase = filteredString
                                            }
                                        
                                        TextField("score-string", text: $squad1pointsscore)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad1pointsscore) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad1pointsscore = filteredString
                                            }
                                    }
                                    //MARK: Player Three + Two Points
                                    GroupBox{
                                        HStack{
                                            Text(displayedGame.squad3.first!)
                                            Text(" && ")
                                            Text(displayedGame.squad2.first!)
                                        }
                                        TextField("base-string", text: $squad3pointsbase)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad3pointsbase) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad3pointsbase = filteredString
                                                squad2pointsbase = filteredString
                                            }
                                        
                                        TextField("score-string", text: $squad3pointsscore)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad3pointsscore) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad3pointsscore = filteredString
                                                squad2pointsscore = filteredString
                                            }
                                    }
                                    
                                }
                                else if (isPlayerTwoSolo){
                                    //MARK: Player Two Solo Points
                                    
                                    GroupBox{
                                        HStack {
                                            Spacer()
                                            Spacer()
                                            Text(displayedGame.squad2.first!)
                                            Spacer()
                                            Button("unmark-text"){
                                                isPlayerTwoSolo = false
                                                isSoloSelected = false
                                            }
                                        }
                                        
                                        TextField("base-string", text: $squad2pointsbase)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad2pointsbase) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad2pointsbase = filteredString
                                            }
                                        
                                        TextField("score-string", text: $squad2pointsscore)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad2pointsscore) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad2pointsscore = filteredString
                                            }
                                    }
                                    //MARK: Player three + one
                                    GroupBox{
                                        HStack{
                                            Text(displayedGame.squad3.first!)
                                            Text(" && ")
                                            Text(displayedGame.squad1.first!)
                                            
                                        }
                                        TextField("base-string", text: $squad3pointsbase)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad3pointsbase) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad3pointsbase = filteredString
                                                squad1pointsbase = filteredString
                                            }
                                        
                                        TextField("score-string", text: $squad3pointsscore)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad3pointsscore) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad3pointsscore = filteredString
                                                squad1pointsscore = filteredString
                                            }
                                    }
                                }
                                else if (isPlayerThreeSolo){
                                    //MARK: Player Three Solo Points
                                    
                                    GroupBox{
                                        HStack {
                                            Spacer()
                                            Spacer()
                                            Text(displayedGame.squad3.first!)
                                            Spacer()
                                            Button("unmark-text"){
                                                isPlayerThreeSolo = false
                                                isSoloSelected = false
                                            }
                                        }
                                        TextField("base-string", text: $squad3pointsbase)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad3pointsbase) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad3pointsbase = filteredString
                                            }
                                        
                                        TextField("score-string", text: $squad3pointsscore)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad3pointsscore) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad3pointsscore = filteredString
                                            }
                                    }
                                    //MARK: Player Two + One Points
                                    GroupBox{
                                        //player 2 points
                                        HStack{
                                            Text(displayedGame.squad2.first!)
                                            Text(" && ")
                                            Text(displayedGame.squad1.first!)
                                        }
                                        TextField("base-string", text: $squad2pointsbase)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad2pointsbase) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad2pointsbase = filteredString
                                                squad1pointsbase = filteredString
                                            }
                                        
                                        TextField("score-string", text: $squad2pointsscore)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad2pointsscore) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad2pointsscore = filteredString
                                                squad1pointsscore = filteredString
                                            }
                                    }
                                    
                                }
                            }
                        }
                        
                        else if displayedGame.gameMode == 4 {
                            
                            //2 vs 2, 2x2 boxes
                            VStack{
                                VStack{
                                    //player 1 points
                                    GroupBox{
                                        Text(displayedGame.squad1.first! + " & " + displayedGame.squad1[1])
                                        TextField("base-string", text: $squad1pointsbase)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad1pointsbase) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad1pointsbase = filteredString
                                            }
                                        
                                        TextField("score-string", text: $squad1pointsscore)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad1pointsscore) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad1pointsscore = filteredString
                                            }
                                    }
                                }.padding()
                                
                                VStack{
                                    GroupBox{
                                        //player 2 points
                                        Text(displayedGame.squad2.first! + " & " + displayedGame.squad2[1])
                                        TextField("base-string", text: $squad2pointsbase)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad2pointsbase) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad2pointsbase = filteredString
                                            }
                                        
                                        TextField("score-string", text: $squad2pointsscore)
                                            .padding().keyboardType(.numbersAndPunctuation)
                                            .onChange(of: squad2pointsscore) { newValue in
                                                var filteredString = ""
                                                for (index, character) in newValue.enumerated() {
                                                    if index == 0 && character == "-" {
                                                        filteredString.append(character)
                                                    }
                                                    else if character.isNumber {
                                                        filteredString.append(character)
                                                    }
                                                }
                                                squad2pointsscore = filteredString
                                            }
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
                            
                        } else{  //Game still going
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
                                
                                if(!isSoloSelected){
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
                                }
                                else if(isSoloSelected){
                                    //MARK: points if solo exists
                                    print("25 - Solo is selected")
                                    // Must handle the solo scenario
                                    if squad3pointsbase == "" {
                                        squad3pointsbase = "0"
                                    }
                                    if squad3pointsscore == "" {
                                        squad3pointsscore = "0"
                                    }
                                    
                                    if(isPlayerOneSolo){
                                        print("25 - Player One is Solo")
                                        var tempPointsBase1 = Double(squad1pointsbase)!
                                        tempPointsBase1 = (tempPointsBase1 / 1.0)
                                        var tempPointsScore1 = Double(squad1pointsscore)!
                                        tempPointsScore1 = (tempPointsScore1 / 1.0)
                                        var tempSumScore1 = Int(tempPointsBase1 + tempPointsScore1)
                                        
                                        displayedGame.currentPoints_p1 += Int(tempSumScore1)
                                        displayedGame.handPoints_p1.append(Int(tempSumScore1))
                                        
                                        var tempPointsBase2 = Double(squad2pointsbase)!
                                        tempPointsBase2 = (tempPointsBase2 / 2.0)
                                        var tempPointsScore2 = Double(squad2pointsscore)!
                                        tempPointsScore2 = (tempPointsScore2 / 2.0)
                                        var tempSumScore2 = Int(tempPointsBase2 + tempPointsScore2)
                                        
                                        displayedGame.currentPoints_p2 += Int(tempSumScore2)
                                        displayedGame.handPoints_p2.append(Int(tempSumScore2))
                                        
                                        var tempPointsBase3 = Double(squad3pointsbase)!
                                        tempPointsBase3 = (tempPointsBase3 / 2.0)
                                        var tempPointsScore3 = Double(squad3pointsscore)!
                                        tempPointsScore3 = (tempPointsScore3 / 2.0)
                                        var tempSumScore3 = Int(tempPointsBase3 + tempPointsScore3)
                                        
                                        displayedGame.currentPoints_p3 += Int(tempSumScore3)
                                        displayedGame.handPoints_p3.append(Int(tempSumScore3))
                                        
                                        dismiss()
                                        GameDetailedView(displayedGame: displayedGame, title: "")
                                    } else if(isPlayerTwoSolo){
                                        var tempPointsBase1 = Double(squad1pointsbase)!
                                        tempPointsBase1 = (tempPointsBase1 / 2.0)
                                        var tempPointsScore1 = Double(squad1pointsscore)!
                                        tempPointsScore1 = (tempPointsScore1 / 2.0)
                                        var tempSumScore1 = Int(tempPointsBase1 + tempPointsScore1)
                                        
                                        displayedGame.currentPoints_p1 += Int(tempSumScore1)
                                        displayedGame.handPoints_p1.append(Int(tempSumScore1))
                                        
                                        var tempPointsBase2 = Double(squad2pointsbase)!
                                        tempPointsBase2 = (tempPointsBase2 / 1.0)
                                        var tempPointsScore2 = Double(squad2pointsscore)!
                                        tempPointsScore2 = (tempPointsScore2 / 1.0)
                                        var tempSumScore2 = Int(tempPointsBase2 + tempPointsScore2)
                                        
                                        displayedGame.currentPoints_p2 += Int(tempSumScore2)
                                        displayedGame.handPoints_p2.append(Int(tempSumScore2))
                                        
                                        var tempPointsBase3 = Double(squad3pointsbase)!
                                        tempPointsBase3 = (tempPointsBase3 / 2.0)
                                        var tempPointsScore3 = Double(squad3pointsscore)!
                                        tempPointsScore3 = (tempPointsScore3 / 2.0)
                                        var tempSumScore3 = Int(tempPointsBase3 + tempPointsScore3)
                                        
                                        displayedGame.currentPoints_p3 += Int(tempSumScore3)
                                        displayedGame.handPoints_p3.append(Int(tempSumScore3))
                                        
                                        dismiss()
                                        GameDetailedView(displayedGame: displayedGame, title: "")
                                        
                                    } else if (isPlayerThreeSolo){
                                        var tempPointsBase1 = Double(squad1pointsbase)!
                                        tempPointsBase1 = (tempPointsBase1 / 2.0)
                                        var tempPointsScore1 = Double(squad1pointsscore)!
                                        tempPointsScore1 = (tempPointsScore1 / 2.0)
                                        var tempSumScore1 = Int(tempPointsBase1 + tempPointsScore1)
                                        
                                        displayedGame.currentPoints_p1 += Int(tempSumScore1)
                                        displayedGame.handPoints_p1.append(Int(tempSumScore1))
                                        
                                        var tempPointsBase2 = Double(squad2pointsbase)!
                                        tempPointsBase2 = (tempPointsBase2 / 2.0)
                                        var tempPointsScore2 = Double(squad2pointsscore)!
                                        tempPointsScore2 = (tempPointsScore2 / 2.0)
                                        var tempSumScore2 = Int(tempPointsBase2 + tempPointsScore2)
                                        
                                        displayedGame.currentPoints_p2 += Int(tempSumScore2)
                                        displayedGame.handPoints_p2.append(Int(tempSumScore2))
                                        
                                        var tempPointsBase3 = Double(squad3pointsbase)!
                                        tempPointsBase3 = (tempPointsBase3 / 1.0)
                                        var tempPointsScore3 = Double(squad3pointsscore)!
                                        tempPointsScore3 = (tempPointsScore3 / 1.0)
                                        var tempSumScore3 = Int(tempPointsBase3 + tempPointsScore3)
                                        
                                        displayedGame.currentPoints_p3 += Int(tempSumScore3)
                                        displayedGame.handPoints_p3.append(Int(tempSumScore3))
                                        
                                        dismiss()
                                        GameDetailedView(displayedGame: displayedGame, title: "")
                                    }
                                    
                                } // end of solo cases
                            }// end of squad3 enabled
                            else if(!(isSoloSelected)) { //There is no squad3 and no solo
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


#Preview {
    GameAddPointsSheetView(displayedGame: Game(timestamp: Date(), maxPoints: Int(2001), gameMode: 3, playerCounter: 3, squad3Enabled: true, squad1: ["squad1"], squad2: ["squad2"], squad3: ["squad3"], currentPoints_p1: 0, currentPoints_p2: 0, currentPoints_p3: 0, handPoints_p1: [0], handPoints_p2: [0], handPoints_p3: [0], handsPlayed: 0, isGameConcluded: false, firstDealer: "None"))
}
