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
    
    @State var squad1PointsBase: Int = 0
    @State var squad1PointsScore: Int = 0
    @State var squad2PointsBase: Int = 0
    @State var squad2PointsScore: Int = 0
    @State var squad3PointsBase: Int = 0
    @State var squad3PointsScore: Int = 0
    
    @State var isSoloSelected = false
    @State var isPlayerOneSolo = false
    @State var isPlayerTwoSolo = false
    @State var isPlayerThreeSolo = false
    
    @Environment(\.modelContext) var modelContext
    @Query var players: [Player]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if displayedGame.isGameConcluded {
                        Text("gameoveradd-string").bold().padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        switch displayedGame.gameMode {
                        case 2:
                            TwoPlayerPointsView(
                                squad1pointsbase: $squad1pointsbase,
                                squad1pointsscore: $squad1pointsscore,
                                squad2pointsbase: $squad2pointsbase,
                                squad2pointsscore: $squad2pointsscore,
                                squad1Name: displayedGame.squad1.first ?? "",
                                squad2Name: displayedGame.squad2.first ?? ""
                            )
                        case 3:
                            ThreePlayerPointsView(
                                squad1pointsbase: $squad1pointsbase,
                                squad1pointsscore: $squad1pointsscore,
                                squad2pointsbase: $squad2pointsbase,
                                squad2pointsscore: $squad2pointsscore,
                                squad3pointsbase: $squad3pointsbase,
                                squad3pointsscore: $squad3pointsscore,
                                squad1Name: displayedGame.squad1.first ?? "",
                                squad2Name: displayedGame.squad2.first ?? "",
                                squad3Name: displayedGame.squad3.first ?? "",
                                isSoloSelected: $isSoloSelected,
                                isPlayerOneSolo: $isPlayerOneSolo,
                                isPlayerTwoSolo: $isPlayerTwoSolo,
                                isPlayerThreeSolo: $isPlayerThreeSolo
                            )
                        case 4:
                            FourPlayerPointsView(
                                squad1pointsbase: $squad1pointsbase,
                                squad1pointsscore: $squad1pointsscore,
                                squad2pointsbase: $squad2pointsbase,
                                squad2pointsscore: $squad2pointsscore,
                                squad1Name: displayedGame.squad1,
                                squad2Name: displayedGame.squad2
                            )
                        default:
                            Text("Invalid game mode")
                        }
                    }
                }
                .navigationBarTitle("addpoints-string", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("done-button-string") {
                            processPoints()
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("cancel-button-string") {
                            resetPoints()
                            dismiss()
                        }
                    }
                }
            }
        }
    }
    
    private func processPoints() {
        if displayedGame.isGameConcluded {
            return
        }
        
        if displayedGame.gameMode == 3 && isSoloSelected {
            processSoloPoints()
        } else {
            processRegularPoints()
        }
    }
    
    private func processRegularPoints(){
        squad1PointsBase = (Int(squad1pointsbase) ?? 0)
        squad1PointsScore = (Int(squad1pointsscore) ?? 0)
        let squad1Points = squad1PointsBase + squad1PointsScore
        
        squad2PointsBase = Int(squad2pointsbase) ?? 0
        squad2PointsScore = Int(squad2pointsscore) ?? 0
        let squad2Points = squad2PointsBase + squad2PointsScore
        
        
        displayedGame.currentPoints_p1 += squad1Points
        displayedGame.currentPoints_p2 += squad2Points
        
        displayedGame.handPoints_p1.append(squad1Points)
        displayedGame.handPoints_p2.append(squad2Points)
        
        if displayedGame.squad3Enabled {
            //TODO: Fix
            squad3PointsBase = (Int(squad3pointsbase) ?? 0)
            squad3PointsScore = (Int(squad3pointsscore) ?? 0)
            let squad3Points = squad3PointsBase + squad3PointsScore
            
            displayedGame.currentPoints_p3 += squad3Points
            displayedGame.handPoints_p3.append(squad3Points)
        }
        
        checkGameConclusion()
        
    }
    
    private func processSoloPoints() {
        let factor = 2.0
        if isPlayerOneSolo {
            print("1908 processing points: player one went solo")
            updateSoloPoints(squad1Points: (Double(squad1pointsbase) ?? 0) + (Double(squad1pointsscore) ?? 0),
                             squad2Points: (Double(squad2pointsbase) ?? 0) / factor + (Double(squad2pointsscore) ?? 0) / factor,
                             squad3Points: (Double(squad3pointsbase) ?? 0) / factor + (Double(squad3pointsscore) ?? 0) / factor)
        } else if isPlayerTwoSolo {
            print("1908 processing points: player TWO went solo")
            updateSoloPoints(squad1Points: (Double(squad1pointsbase) ?? 0) / factor + (Double(squad1pointsscore) ?? 0) / factor,
                             squad2Points: (Double(squad2pointsbase) ?? 0)  + (Double(squad2pointsscore) ?? 0),
                             squad3Points: (Double(squad3pointsbase) ?? 0) / factor + (Double(squad3pointsscore) ?? 0) / factor)
        } else if isPlayerThreeSolo {
            print("1908 processing points: player THREE went solo")
            updateSoloPoints(squad1Points: (Double(squad1pointsbase) ?? 0) / factor + (Double(squad1pointsscore) ?? 0) / factor ,
                             squad2Points: (Double(squad2pointsbase) ?? 0) / factor + (Double(squad2pointsscore) ?? 0) / factor,
                             squad3Points: (Double(squad3pointsbase) ?? 0) + (Double(squad3pointsscore) ?? 0) )
        }
        checkGameConclusion()
    }
    
    private func updateSoloPoints(squad1Points: Double, squad2Points: Double, squad3Points: Double) {
        displayedGame.currentPoints_p1 += Int(squad1Points)
        displayedGame.currentPoints_p2 += Int(squad2Points)
        displayedGame.currentPoints_p3 += Int(squad3Points)
        displayedGame.handPoints_p1.append(Int(squad1Points))
        displayedGame.handPoints_p2.append(Int(squad2Points))
        displayedGame.handPoints_p3.append(Int(squad3Points))
    }
    
    private func checkGameConclusion() {
        if displayedGame.currentPoints_p1 >= displayedGame.maxPoints ||
            displayedGame.currentPoints_p2 >= displayedGame.maxPoints ||
            displayedGame.currentPoints_p3 >= displayedGame.maxPoints {
            displayedGame.isGameConcluded = true
            //TODO: add win
            processConcludedGame()
            
        }
    }
    
    private func checkIfSquadHasMostPoints(squadToCheck: Int) -> Bool{
        switch squadToCheck {
        case 1:
            if displayedGame.currentPoints_p1 >= displayedGame.maxPoints && displayedGame.currentPoints_p1 > displayedGame.currentPoints_p2 && displayedGame.currentPoints_p1 > displayedGame.currentPoints_p3 {
               return true
            }
        case 2:
            if displayedGame.currentPoints_p2 >= displayedGame.maxPoints && displayedGame.currentPoints_p2 > displayedGame.currentPoints_p1 && displayedGame.currentPoints_p2 > displayedGame.currentPoints_p3 {
               return true
            }
        case 3:
            if displayedGame.currentPoints_p3 >= displayedGame.maxPoints && displayedGame.currentPoints_p3 > displayedGame.currentPoints_p1 && displayedGame.currentPoints_p3 > displayedGame.currentPoints_p2 {
                return true
            }
        default: return false
        }
        
        return false
    }
    
    
    private func processThirdSquadConcludedGame() {
        if displayedGame.currentPoints_p3 >= displayedGame.maxPoints && checkIfSquadHasMostPoints(squadToCheck: 3){
            giveTheUserAWin(username: displayedGame.squad3.first!)
            giveTheUserALoss(username: displayedGame.squad2.first!)
            giveTheUserALoss(username: displayedGame.squad1.first!)
        } else if displayedGame.currentPoints_p1 >= displayedGame.maxPoints && checkIfSquadHasMostPoints(squadToCheck: 1){
            giveTheUserAWin(username: displayedGame.squad1.first!)
            giveTheUserALoss(username: displayedGame.squad2.first!)
            giveTheUserALoss(username: displayedGame.squad3.first!)
        } else if displayedGame.currentPoints_p2 >= displayedGame.maxPoints && checkIfSquadHasMostPoints(squadToCheck: 2){
            giveTheUserAWin(username: displayedGame.squad2.first!)
            giveTheUserALoss(username: displayedGame.squad1.first!)
            giveTheUserALoss(username: displayedGame.squad3.first!)
        }
    }
    
    private func processConcludedGame() {
        if(displayedGame.squad3Enabled){
            processThirdSquadConcludedGame()
        } else {
            if displayedGame.currentPoints_p1 >= displayedGame.maxPoints && checkIfSquadHasMostPoints(squadToCheck: 1) {
                giveTheUserAWin(username: displayedGame.squad1.first!)
                giveTheUserALoss(username: displayedGame.squad2.first!)
                
                if(displayedGame.squad1.count > 1){
                    giveTheUserAWin(username: displayedGame.squad1[1])
                    giveTheUserALoss(username: displayedGame.squad2[1])
                }
                
            } else if displayedGame.currentPoints_p2 >= displayedGame.maxPoints && checkIfSquadHasMostPoints(squadToCheck: 2){
                giveTheUserAWin(username: displayedGame.squad2.first!)
                giveTheUserALoss(username: displayedGame.squad1.first!)
                
                if(displayedGame.squad2.count > 1){
                    giveTheUserAWin(username: displayedGame.squad2[1])
                    giveTheUserALoss(username: displayedGame.squad1[1])
                }
            }
        }
    }
    
    //End
    
    private func giveTheUserAWin (username: String){
        for player in players {
            if player.name == username {
                player.numberOfGamePlayed += 1
                player.numberOfGameWon += 1
            }
        }
    }
    
    private func giveTheUserALoss (username: String){
        for player in players {
            if player.name == username {
                player.numberOfGamePlayed += 1
            }
        }
    }
    
    private func resetPoints() {
        squad1pointsbase = ""
        squad1pointsscore = ""
        squad2pointsbase = ""
        squad2pointsscore = ""
        squad3pointsbase = ""
        squad3pointsscore = ""
    }
}

struct TwoPlayerPointsView: View {
    @Binding var squad1pointsbase: String
    @Binding var squad1pointsscore: String
    @Binding var squad2pointsbase: String
    @Binding var squad2pointsscore: String
    
    var squad1Name: String
    var squad2Name: String
    
    var body: some View {
        VStack {
            PointsInputView(playerName: squad1Name, pointsbase: $squad1pointsbase, pointsscore: $squad1pointsscore)
            PointsInputView(playerName: squad2Name, pointsbase: $squad2pointsbase, pointsscore: $squad2pointsscore)
        }.padding()
    }
}

struct ThreePlayerPointsView: View {
    @Binding var squad1pointsbase: String
    @Binding var squad1pointsscore: String
    @Binding var squad2pointsbase: String
    @Binding var squad2pointsscore: String
    @Binding var squad3pointsbase: String
    @Binding var squad3pointsscore: String
    
    var squad1Name: String
    var squad2Name: String
    var squad3Name: String
    
    @Binding var isSoloSelected: Bool
    @Binding var isPlayerOneSolo: Bool
    @Binding var isPlayerTwoSolo: Bool
    @Binding var isPlayerThreeSolo: Bool
    
    var body: some View {
        VStack {
            if isSoloSelected {
                SoloPointsView(squad1Name: squad1Name, squad2Name: squad2Name, squad3Name: squad3Name,
                               squad1pointsbase: $squad1pointsbase, squad1pointsscore: $squad1pointsscore,
                               squad2pointsbase: $squad2pointsbase, squad2pointsscore: $squad2pointsscore,
                               squad3pointsbase: $squad3pointsbase, squad3pointsscore: $squad3pointsscore,
                               
                               isPlayerOneSolo: $isPlayerOneSolo, isPlayerTwoSolo: $isPlayerTwoSolo, isPlayerThreeSolo: $isPlayerThreeSolo,
                               isSoloSelected: $isSoloSelected)
            } else {
                RegularThreePlayerPointsView(squad1Name: squad1Name, squad2Name: squad2Name, squad3Name: squad3Name,
                                             squad1pointsbase: $squad1pointsbase, squad1pointsscore: $squad1pointsscore,
                                             squad2pointsbase: $squad2pointsbase, squad2pointsscore: $squad2pointsscore,
                                             squad3pointsbase: $squad3pointsbase, squad3pointsscore: $squad3pointsscore,
                                             isSoloSelected: $isSoloSelected, isPlayerOneSolo: $isPlayerOneSolo, isPlayerTwoSolo: $isPlayerTwoSolo, isPlayerThreeSolo: $isPlayerThreeSolo)
            }
        }.padding()
    }
}

struct FourPlayerPointsView: View {
    @Binding var squad1pointsbase: String
    @Binding var squad1pointsscore: String
    @Binding var squad2pointsbase: String
    @Binding var squad2pointsscore: String
    
    var squad1Name: [String]
    var squad2Name: [String]
    
    var body: some View {
        VStack {
            PointsInputView(playerName: "\(squad1Name[0]) & \(squad1Name[1])", pointsbase: $squad1pointsbase, pointsscore: $squad1pointsscore)
            PointsInputView(playerName: "\(squad2Name[0]) & \(squad2Name[1])", pointsbase: $squad2pointsbase, pointsscore: $squad2pointsscore)
        }.padding()
    }
}

struct PointsInputView: View {
    var playerName: String
    @Binding var pointsbase: String
    @Binding var pointsscore: String
    
    var body: some View {
        GroupBox {
            HStack{
                Text(playerName)
                    .padding(.leading, 10)
                Spacer()
            }
            TextField("base-string", text: $pointsbase)
                .padding().keyboardType(.numbersAndPunctuation)
                .onChange(of: pointsbase) {_, newValue in
                    pointsbase = filterInput(newValue)
                }
            
            TextField("score-string", text: $pointsscore)
                .padding().keyboardType(.numbersAndPunctuation)
                .onChange(of: pointsscore) {_, newValue in
                    pointsscore = filterInput(newValue)
                }
        }
    }
    
    private func filterInput(_ input: String) -> String {
        var filteredString = ""
        for (index, character) in input.enumerated() {
            if index == 0 && character == "-" {
                filteredString.append(character)
            } else if character.isNumber {
                filteredString.append(character)
            }
        }
        return filteredString
    }
}

struct RegularThreePlayerPointsView: View {
    var squad1Name: String
    var squad2Name: String
    var squad3Name: String
    
    @Binding var squad1pointsbase: String
    @Binding var squad1pointsscore: String
    @Binding var squad2pointsbase: String
    @Binding var squad2pointsscore: String
    @Binding var squad3pointsbase: String
    @Binding var squad3pointsscore: String
    
    @Binding var isSoloSelected: Bool
    @Binding var isPlayerOneSolo: Bool
    @Binding var isPlayerTwoSolo: Bool
    @Binding var isPlayerThreeSolo: Bool
    
    var body: some View {
        VStack {
            VStack{
                ZStack{
                    PointsInputView(playerName: squad1Name, pointsbase: $squad1pointsbase, pointsscore: $squad1pointsscore)
                    VStack{
                        HStack{
                            Spacer()
                            Spacer()
                            Button("mark-solo") {
                                isSoloSelected = true
                                isPlayerOneSolo = true
                            }
                            .padding()
                        }
                        Spacer()
                    }
                }
            }.padding(.bottom, 20)
            
            VStack{
                ZStack{
                    PointsInputView(playerName: squad2Name, pointsbase: $squad2pointsbase, pointsscore: $squad2pointsscore)
                    VStack{
                        HStack{
                            Spacer()
                            Spacer()
                            Button("mark-solo") {
                                isSoloSelected = true
                                isPlayerTwoSolo = true
                            }
                            .padding()
                        }
                        Spacer()
                    }
                }
            }.padding(.bottom, 20)
            
            VStack{
                ZStack{
                    PointsInputView(playerName: squad3Name, pointsbase: $squad3pointsbase, pointsscore: $squad3pointsscore)
                    VStack{
                        HStack{
                            Spacer()
                            Spacer()
                            Button("mark-solo") {
                                isSoloSelected = true
                                isPlayerThreeSolo = true
                            }
                            .padding()
                        }
                        Spacer()
                    }
                }
            }
            
            
            
        }.padding()
    }
}

struct SoloPointsView: View {
    var squad1Name: String
    var squad2Name: String
    var squad3Name: String
    
    @Binding var squad1pointsbase: String
    @Binding var squad1pointsscore: String
    @Binding var squad2pointsbase: String
    @Binding var squad2pointsscore: String
    @Binding var squad3pointsbase: String
    @Binding var squad3pointsscore: String
    
    @Binding var isPlayerOneSolo: Bool
    @Binding var isPlayerTwoSolo: Bool
    @Binding var isPlayerThreeSolo: Bool
    @Binding var isSoloSelected: Bool
    
    var body: some View {
        VStack {
            if isPlayerOneSolo {
                SoloPlayerPointsView(playerName: squad1Name, pointsbase: $squad1pointsbase, pointsscore: $squad1pointsscore, isPlayerSolo: $isPlayerOneSolo, isSoloSelected: $isSoloSelected)
                CombinedPlayerPointsView(player1Name: squad2Name, player2Name: squad3Name, pointsbase1: $squad2pointsbase, pointsscore1: $squad2pointsscore, pointsbase2: $squad3pointsbase, pointsscore2: $squad3pointsscore)
            } else if isPlayerTwoSolo {
                // When p2 is solo, points of solo get added to player 1
                SoloPlayerPointsView(playerName: squad2Name, pointsbase: $squad2pointsbase, pointsscore: $squad2pointsscore, isPlayerSolo: $isPlayerTwoSolo, isSoloSelected: $isSoloSelected)
                
                CombinedPlayerPointsView(player1Name: squad1Name, player2Name: squad3Name, pointsbase1: $squad1pointsbase, pointsscore1: $squad1pointsscore, pointsbase2: $squad3pointsbase, pointsscore2: $squad3pointsscore)
                
            } else if isPlayerThreeSolo {
                SoloPlayerPointsView(playerName: squad3Name, pointsbase: $squad3pointsbase, pointsscore: $squad3pointsscore, isPlayerSolo: $isPlayerThreeSolo, isSoloSelected: $isSoloSelected)
                
                CombinedPlayerPointsView(player1Name: squad1Name, player2Name: squad2Name, pointsbase1: $squad1pointsbase, pointsscore1: $squad1pointsscore, pointsbase2: $squad2pointsbase, pointsscore2: $squad2pointsscore)
            }
        }.padding()
    }
}

struct SoloPlayerPointsView: View {
    var playerName: String
    @Binding var pointsbase: String
    @Binding var pointsscore: String
    @Binding var isPlayerSolo: Bool
    @Binding var isSoloSelected: Bool
    
    var body: some View {
        GroupBox {
            HStack {
                Spacer()
                Text(playerName)
                Spacer()
                Button("unmark-solo") {
                    isPlayerSolo = false
                    isSoloSelected = false
                }
            }
            TextField("base-string", text: $pointsbase)
                .padding().keyboardType(.numbersAndPunctuation)
                .onChange(of: pointsbase) {_, newValue in
                    pointsbase = filterInput(newValue)
                }
            
            TextField("score-string", text: $pointsscore)
                .padding().keyboardType(.numbersAndPunctuation)
                .onChange(of: pointsscore) {_, newValue in
                    pointsscore = filterInput(newValue)
                }
        }
    }
    
    private func filterInput(_ input: String) -> String {
        var filteredString = ""
        for (index, character) in input.enumerated() {
            if index == 0 && character == "-" {
                filteredString.append(character)
            } else if character.isNumber {
                filteredString.append(character)
            }
        }
        return filteredString
    }
}

struct CombinedPlayerPointsView: View {
    var player1Name: String
    var player2Name: String
    @Binding var pointsbase1: String
    @Binding var pointsscore1: String
    @Binding var pointsbase2: String
    @Binding var pointsscore2: String
    
    var body: some View {
        GroupBox {
            HStack {
                Text(player1Name)
                Text(" && ")
                Text(player2Name)
            }
            TextField("base-string", text: $pointsbase1)
                .padding().keyboardType(.numbersAndPunctuation)
                .onChange(of: pointsbase1) {_, newValue in
                    pointsbase1 = filterInput(newValue)
                    pointsbase2 = filterInput(newValue)
                }
            
            TextField("score-string", text: $pointsscore1)
                .padding().keyboardType(.numbersAndPunctuation)
                .onChange(of: pointsscore1) {_, newValue in
                    pointsscore1 = filterInput(newValue)
                    pointsscore2 = filterInput(newValue)
                }
        }
    }
    
    private func filterInput(_ input: String) -> String {
        var filteredString = ""
        for (index, character) in input.enumerated() {
            if index == 0 && character == "-" {
                filteredString.append(character)
            } else if character.isNumber {
                filteredString.append(character)
            }
        }
        return filteredString
    }
}


