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
    
    private func processRegularPoints() {
        let squad1Points = Int(squad1pointsbase) ?? 0 + (Int(squad1pointsscore) ?? 0)
        let squad2Points = Int(squad2pointsbase) ?? 0 + (Int(squad2pointsscore) ?? 0)
        
        displayedGame.currentPoints_p1 += squad1Points
        displayedGame.currentPoints_p2 += squad2Points
        displayedGame.handPoints_p1.append(squad1Points)
        displayedGame.handPoints_p2.append(squad2Points)
        
        if displayedGame.squad3Enabled {
            let squad3Points = Int(squad3pointsbase) ?? 0 + (Int(squad3pointsscore) ?? 0)
            displayedGame.currentPoints_p3 += squad3Points
            displayedGame.handPoints_p3.append(squad3Points)
        }
        
        checkGameConclusion()
    }
    
    private func processSoloPoints() {
        let factor = 2.0
        if isPlayerOneSolo {
            updateSoloPoints(squadSoloPoints: (Double(squad1pointsbase) ?? 0) + (Double(squad1pointsscore) ?? 0),
                             squad2Points: (Double(squad2pointsbase) ?? 0) / factor + (Double(squad2pointsscore) ?? 0) / factor,
                             squad3Points: (Double(squad3pointsbase) ?? 0) / factor + (Double(squad3pointsscore) ?? 0) / factor)
        } else if isPlayerTwoSolo {
            updateSoloPoints(squadSoloPoints: (Double(squad2pointsbase) ?? 0) + (Double(squad2pointsscore) ?? 0),
                             squad2Points: (Double(squad1pointsbase) ?? 0) / factor + (Double(squad1pointsscore) ?? 0) / factor,
                             squad3Points: (Double(squad3pointsbase) ?? 0) / factor + (Double(squad3pointsscore) ?? 0) / factor)
        } else if isPlayerThreeSolo {
            updateSoloPoints(squadSoloPoints: (Double(squad3pointsbase) ?? 0) + (Double(squad3pointsscore) ?? 0),
                             squad2Points: (Double(squad1pointsbase) ?? 0) / factor + (Double(squad1pointsscore) ?? 0) / factor,
                             squad3Points: (Double(squad2pointsbase) ?? 0) / factor + (Double(squad2pointsscore) ?? 0) / factor)
        }
    }
    
    private func updateSoloPoints(squadSoloPoints: Double, squad2Points: Double, squad3Points: Double) {
        displayedGame.currentPoints_p1 += Int(squadSoloPoints)
        displayedGame.currentPoints_p2 += Int(squad2Points)
        displayedGame.currentPoints_p3 += Int(squad3Points)
        displayedGame.handPoints_p1.append(Int(squadSoloPoints))
        displayedGame.handPoints_p2.append(Int(squad2Points))
        displayedGame.handPoints_p3.append(Int(squad3Points))
    }
    
    private func checkGameConclusion() {
        if displayedGame.currentPoints_p1 >= displayedGame.maxPoints ||
            displayedGame.currentPoints_p2 >= displayedGame.maxPoints ||
            displayedGame.currentPoints_p3 >= displayedGame.maxPoints {
            displayedGame.isGameConcluded = true
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
            Text(playerName)
            TextField("base-string", text: $pointsbase)
                .padding().keyboardType(.numbersAndPunctuation)
                .onChange(of: pointsbase) { newValue in
                    pointsbase = filterInput(newValue)
                }
            
            TextField("score-string", text: $pointsscore)
                .padding().keyboardType(.numbersAndPunctuation)
                .onChange(of: pointsscore) { newValue in
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
            PointsInputView(playerName: squad1Name, pointsbase: $squad1pointsbase, pointsscore: $squad1pointsscore)
            Button("mark-solo") {
                isSoloSelected = true
                isPlayerOneSolo = true
            }
            PointsInputView(playerName: squad2Name, pointsbase: $squad2pointsbase, pointsscore: $squad2pointsscore)
            Button("mark-solo") {
                isSoloSelected = true
                isPlayerTwoSolo = true
            }
            PointsInputView(playerName: squad3Name, pointsbase: $squad3pointsbase, pointsscore: $squad3pointsscore)
            Button("mark-solo") {
                isSoloSelected = true
                isPlayerThreeSolo = true
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
                SoloPlayerPointsView(playerName: squad2Name, pointsbase: $squad2pointsbase, pointsscore: $squad2pointsscore, isPlayerSolo: $isPlayerTwoSolo, isSoloSelected: $isSoloSelected)
                CombinedPlayerPointsView(player1Name: squad1Name, player2Name: squad3Name, pointsbase1: $squad1pointsbase, pointsscore1: $squad1pointsscore, pointsbase2: $squad3pointsbase, pointsscore2: $squad3pointsscore)
            } else if isPlayerThreeSolo {
                SoloPlayerPointsView(playerName: squad3Name, pointsbase: $squad3pointsbase, pointsscore: $squad3pointsscore, isPlayerSolo: $isPlayerThreeSolo, isSoloSelected: $isSoloSelected)
                CombinedPlayerPointsView(player1Name: squad1Name, player2Name: squad2Name, pointsbase1: $squad1pointsbase, pointsscore1: $squad1pointsscore, pointsbase2: $squad3pointsbase, pointsscore2: $squad3pointsscore)
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
                .onChange(of: pointsbase) { newValue in
                    pointsbase = filterInput(newValue)
                }
            
            TextField("score-string", text: $pointsscore)
                .padding().keyboardType(.numbersAndPunctuation)
                .onChange(of: pointsscore) { newValue in
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
                .onChange(of: pointsbase1) { newValue in
                    pointsbase1 = filterInput(newValue)
                    pointsbase2 = filterInput(newValue)
                }
            
            TextField("score-string", text: $pointsscore1)
                .padding().keyboardType(.numbersAndPunctuation)
                .onChange(of: pointsscore1) { newValue in
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


