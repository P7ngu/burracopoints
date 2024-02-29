//
//  GameDetailedView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 16/11/23.
//

import SwiftUI
import SwiftData


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
                                    HStack{
                                        Text("points-section-string")
                                        Text(String(displayedGame.currentPoints_p1)).bold()
                                    }.padding()
                                }//.padding()
                               
                                
                                ForEach(1..<displayedGame.handPoints_p1.count, id: \.self){ index in
                                    HStack{
                                        //Text("hand-string")
                                        Text("#" + String(index) + ":")
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
                                        //Text("hand-string")
                                        Text("#" + String(index) + ":")
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
                            } .onChange(of: selectedDealer){
                                if(selectedDealer != "None"){
                                    displayedGame.firstDealer = selectedDealer
                                }
                            }
                        }
                        
                    }
                    // 1 vs 1 vs 1, 3 boxes
                    VStack{
                        VStack{
                            GroupBox{ //player 1 points
                                HStack{
                                    Text(displayedGame.squad1.first!)
                                    if(displayedGame.firstDealer == displayedGame.squad1.first! ){
                                        Text(" *").bold().foregroundStyle(Color("AccentColor1"))
                                    }
                                }
                                HStack{
                                    Text("points-section-string")
                                    Text(String(displayedGame.currentPoints_p1))
                                }
                                Text("")
                                ForEach(1..<displayedGame.handPoints_p1.count, id: \.self){ index in
                                    HStack{
                                        //Text("hand-string")
                                        Text("#" + String(index) + ":")
                                        Text(String(displayedGame.handPoints_p1[index]))
                                    }
                                }
                                .frame(minWidth: 300)
                            }
                        }
                        VStack{
                            GroupBox{ //player 2 points
                                HStack{
                                    Text(displayedGame.squad2.first!)
                                    if(displayedGame.firstDealer == displayedGame.squad2.first! ){
                                        Text(" *").bold().foregroundStyle(Color("AccentColor1"))
                                    }
                                }
                                HStack{
                                    Text("points-section-string")
                                    Text(String(displayedGame.currentPoints_p2))
                                }
                                Text("")
                                ForEach(1..<displayedGame.handPoints_p2.count, id: \.self){ index in
                                    HStack{
                                        //Text("hand-string")
                                        Text("#" + String(index) + ":")
                                        Text(String(displayedGame.handPoints_p2[index]))
                                    }
                                }
                                .frame(minWidth: 300)
                            }
                        }
                        
                        VStack{
                            GroupBox{
                                //player 3 points
                                HStack{
                                    Text(displayedGame.squad3.first!)
                                    if(displayedGame.firstDealer == displayedGame.squad3.first! ){
                                        Text(" *").bold().foregroundStyle(Color("AccentColor1"))
                                    }
                                }
                                HStack{
                                    Text("points-section-string")
                                    Text(String(displayedGame.currentPoints_p3))
                                }
                                Text("")
                                ForEach(1..<displayedGame.handPoints_p3.count, id: \.self){ index in
                                    HStack{
                                        //Text("hand-string")
                                        Text("#" + String(index) + ":")
                                        Text(String(displayedGame.handPoints_p3[index]))
                                    }
                                }
                                .frame(minWidth: 300)
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
                            }.onChange(of: selectedDealer){
                                if(selectedDealer != "None"){
                                    displayedGame.firstDealer = selectedDealer
                                }
                            }
                        }
                    }
                    //2 vs 2, 2x2 boxes
                    HStack{
                        VStack{
                            //player 1 points
                            GroupBox{
                                HStack{
                                    Text(displayedGame.squad1.first!)
                                    if(displayedGame.firstDealer == displayedGame.squad1.first!) { Text("*").bold().foregroundStyle(Color("AccentColor1")) }
                                    Text("&")
                                    Text( displayedGame.squad1[1])
                                    if(displayedGame.firstDealer == displayedGame.squad1[1]) { Text("*").bold().foregroundStyle(Color("AccentColor1")) }
                                }
                              
                                
                                HStack{
                                    Text("points-section-string")
                                    Text(String(displayedGame.currentPoints_p1))
                                }
                                Text("")
                                ForEach(1..<displayedGame.handPoints_p1.count, id: \.self){ index in
                                   // Text("hand-string")
                                    HStack{
                                        Text("#" + String(index) + ":")
                                        Text(String(displayedGame.handPoints_p1[index]))
                                    }
                                }
                            }
                        }
                        VStack{
                            GroupBox{
                                //player 2 points
                                HStack{
                                    Text(displayedGame.squad2.first!)
                                    if(displayedGame.firstDealer == displayedGame.squad2.first!) { Text("*").bold().foregroundStyle(Color("AccentColor1")) }
                                    Text("&")
                                    Text( displayedGame.squad2[1])
                                    if(displayedGame.firstDealer == displayedGame.squad2[1]) { Text("*").bold().foregroundStyle(Color("AccentColor1")) }
                                }
                                HStack{
                                    Text("points-section-string")
                                    Text(String(displayedGame.currentPoints_p2))
                                }
                                Text("")
                                ForEach(1..<displayedGame.handPoints_p2.count, id: \.self){ index in
                                    //Text("hand-string")
                                    HStack{
                                        Text("#" + String(index) + ":")
                                        Text(String(displayedGame.handPoints_p2[index]))
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                }
            }
        }.scrollIndicators(.hidden)
            .onAppear(){
                print(displayedGame.firstDealer)
                trigger += 1
                if(displayedGame.squad3.first! != "nil"){
                    title = displayedGame.squad1.first! + " vs " + displayedGame.squad2.first! + " vs " + displayedGame.squad3.first!
                } else {
                    title = displayedGame.squad1.first! + " vs " + displayedGame.squad2.first!
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem{
                    Button("Undo") {
                        if(displayedGame.handPoints_p1.count > 1){
                            showingAlert = true
                        }
                    }
                    .alert(isPresented:$showingAlert) {
                        //Undoing the last insertion
                        Alert(
                            title: Text("Are you sure you want to undo the last insertion?"),
                            message: Text("There is no way back"),
                            primaryButton: .destructive(Text("Confirm")) {
                                if(displayedGame.handPoints_p1.count > 1 && displayedGame.handPoints_p2.count > 1){
                                    displayedGame.currentPoints_p1 -= displayedGame.handPoints_p1.last!
                                    displayedGame.currentPoints_p2 -= displayedGame.handPoints_p2.last!
                                    //displayedGame.handsPlayed = displayedGame.handsPlayed-1
                                    displayedGame.handPoints_p1.remove(at: displayedGame.handPoints_p1.count - 1)
                                    displayedGame.handPoints_p2.remove(at: displayedGame.handPoints_p2.count - 1)
                                    
                                    if(displayedGame.squad3Enabled){
                                        displayedGame.currentPoints_p3 -= displayedGame.handPoints_p3.last!
                                        displayedGame.handPoints_p3.remove(at: displayedGame.handPoints_p3.count - 1)
                                    }
                                    displayedGame.isGameConcluded = false;
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
                        GameAddPointsSheetView(displayedGame: displayedGame)
                    }
                }
                
            }
        
    }
    
    func undoPoints(){
        showingAlert = true
    }
    
    
    func addPoints(){
        showingSheet = true
    }
}



