import SwiftUI
import SwiftData



struct GameDetailedView: View {
    @State public var showingAlert = false
    @State public var displayedGame: Game
    @State var title: String
    @State public var showingSheet = false
    @State public var selectedDealer = "None"
    @State var trigger = 0
    
    var body: some View {
        ScrollView {
            VStack {
                switch displayedGame.gameMode {
                case 2:
                    TwoPlayerModeView(displayedGame: $displayedGame, selectedDealer: $selectedDealer)
                case 3:
                    ThreePlayerModeView(displayedGame: $displayedGame, selectedDealer: $selectedDealer)
                case 4:
                    FourPlayerModeView(displayedGame: $displayedGame,selectedDealer: $selectedDealer)
                default:
                    Text("Invalid game mode")
                }
            }
        }
        .scrollIndicators(.hidden)
        .onAppear {
            setupTitle()
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Undo") {
                    if displayedGame.handPoints_p1.count > 1 {
                        showingAlert = true
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Are you sure you want to undo the last insertion?"), message: Text("There is no way back"), primaryButton: .destructive(Text("Confirm")) {
                            if displayedGame.handPoints_p1.count > 1 && displayedGame.handPoints_p2.count > 1 {
                                displayedGame.currentPoints_p1 -= displayedGame.handPoints_p1.last!
                                displayedGame.currentPoints_p2 -= displayedGame.handPoints_p2.last!
                                displayedGame.handPoints_p1.removeLast()
                                displayedGame.handPoints_p2.removeLast()
                                
                                if displayedGame.squad3Enabled {
                                    displayedGame.currentPoints_p3 -= displayedGame.handPoints_p3.last!
                                    displayedGame.handPoints_p3.removeLast()
                                }
                                displayedGame.isGameConcluded = false
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingSheet = true
                }) {
                    Label("addpoints-string", systemImage: "note.text.badge.plus")
                }
                .sheet(isPresented: $showingSheet) {
                GameAddPointsSheetView(displayedGame: displayedGame)
                }
            }
        }
    }
    
    private func setupTitle() {
        if displayedGame.squad3.first != "nil" {
            title = "\(displayedGame.squad1.first ?? "") vs \(displayedGame.squad2.first ?? "") vs \(displayedGame.squad3.first ?? "")"
        } else if displayedGame.gameMode == 2 {
            title = "\(displayedGame.squad1.first ?? "") vs \(displayedGame.squad2.first ?? "")"
        } else if displayedGame.gameMode == 4 {
            title = "\(displayedGame.squad1.first ?? "") & \(displayedGame.squad1[1]) vs \(displayedGame.squad2.first ?? "") & \(displayedGame.squad2[1])"
        }
    }
}

struct GameOverView: View {
    @Binding var trigger: Int
    
    var body: some View {
        VStack {
            Text("gameover-string")
                .bold()
                .font(.title3)
            Image(systemName: "flag.checkered.2.crossed")
                .bold()
                .symbolEffect(.bounce, value: trigger)
                .font(.largeTitle)
                .onTapGesture {
                    trigger += 1
                }
        }
    }
}

struct TwoPlayerModeView: View {
    @Binding var displayedGame: Game
    @Binding var selectedDealer: String
    
    var body: some View {
        VStack {
            if displayedGame.firstDealer == "None" {
                DealerPickerView(selectedDealer: $selectedDealer, players: [displayedGame.squad1.first!, displayedGame.squad2.first!])
            }
            
            PlayerPointsView(displayedGame: displayedGame, players: displayedGame.squad1, currentPoints: displayedGame.currentPoints_p1, handPoints: displayedGame.handPoints_p1, isDealer: displayedGame.firstDealer == displayedGame.squad1.first!)
            PlayerPointsView(displayedGame: displayedGame, players: displayedGame.squad2, currentPoints: displayedGame.currentPoints_p2, handPoints: displayedGame.handPoints_p2, isDealer: displayedGame.firstDealer == displayedGame.squad2.first!)
        }
    }
}

struct ThreePlayerModeView: View {
    @Binding var displayedGame: Game
    @Binding var selectedDealer: String
    
    var body: some View {
        VStack {
            if displayedGame.firstDealer == "None" {
                DealerPickerView(selectedDealer: $selectedDealer, players: [displayedGame.squad1.first!, displayedGame.squad2.first!, displayedGame.squad3.first!])
            }
            
            PlayerPointsView(displayedGame: displayedGame, players: displayedGame.squad1, currentPoints: displayedGame.currentPoints_p1, handPoints: displayedGame.handPoints_p1, isDealer: displayedGame.firstDealer == displayedGame.squad1.first!)
            PlayerPointsView(displayedGame: displayedGame, players: displayedGame.squad2, currentPoints: displayedGame.currentPoints_p2, handPoints: displayedGame.handPoints_p2, isDealer: displayedGame.firstDealer == displayedGame.squad2.first!)
            PlayerPointsView(displayedGame: displayedGame, players: displayedGame.squad3, currentPoints: displayedGame.currentPoints_p3, handPoints: displayedGame.handPoints_p3, isDealer: displayedGame.firstDealer == displayedGame.squad3.first!)
        }
    }
}

struct FourPlayerModeView: View {
    @Binding var displayedGame: Game
    @Binding var selectedDealer: String
    
    var body: some View {
        VStack {
            if displayedGame.firstDealer == "None" {
                DealerPickerView(selectedDealer: $selectedDealer, players: [displayedGame.squad1.first!, displayedGame.squad1[1], displayedGame.squad2.first!, displayedGame.squad2[1]])
            }
            
            PlayerPointsView(displayedGame: displayedGame, players: [displayedGame.squad1.first!, displayedGame.squad1[1]], currentPoints: displayedGame.currentPoints_p1, handPoints: displayedGame.handPoints_p1, isDealer: displayedGame.firstDealer == displayedGame.squad1.first! || displayedGame.firstDealer == displayedGame.squad1[1])
            PlayerPointsView(displayedGame: displayedGame, players: [displayedGame.squad2.first!, displayedGame.squad2[1]], currentPoints: displayedGame.currentPoints_p2, handPoints: displayedGame.handPoints_p2, isDealer: displayedGame.firstDealer == displayedGame.squad2.first! || displayedGame.firstDealer == displayedGame.squad2[1])
        }
    }
}

struct PlayerPointsView: View {
    var displayedGame: Game
    var players: [String]
    var currentPoints: Int
    var handPoints: [Int]
    var isDealer: Bool
    
    var body: some View {
        GroupBox {
            VStack {
                HStack {
                    ForEach(players, id: \.self) { player in
                        Text(player).bold()
                    }
                    if isDealer {
                        Text(" *").bold().foregroundStyle(Color("AccentColor1"))
                    }
                }
                HStack {
                    Text("points-section-string")
                    Text(String(currentPoints))
                }.padding()
                
                ForEach(1..<handPoints.count, id: \.self) { index in
                    HStack {
                        Text("#" + String(index) + ":")
                        Text(String(handPoints[index]))
                    }
                }
            }
            .frame(minWidth: 150, minHeight: 80)
        }
    }
}

struct DealerPickerView: View {
    @Binding var selectedDealer: String
    var players: [String]
    
    var body: some View {
        GroupBox {
            Text("dealer-string")
            Picker(selection: $selectedDealer, label: Text("dealer-string")) {
                ForEach(players, id: \.self) { player in
                    Text(player).tag(player)
                }
                Text("None").tag("None")
            }
            .onChange(of: selectedDealer) { newValue in
                if newValue != "None" {
                    // Handle dealer change logic
                }
            }
        }
    }
}




