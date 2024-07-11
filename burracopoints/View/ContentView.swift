//
//  ContentView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import SwiftUI
import SwiftData
import StoreKit

struct ContentView: View {
    @State private var showingSheet = false
    @Environment(\.modelContext) var modelContext
    @Query private var gameItems: [Game]
    @Query private var players: [Player]
    @State private var bestPlayers: [Player] = []
    @State var fulltitle: String = "..."
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    List {
                        ForEach(gameItems.reversed()) { game in // reversed, so the most recent games go on top.
                            NavigationLink {
                                GameDetailedView(displayedGame: game, title: fulltitle)
                            } label: {
                                GameRowView(game: game)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    modelContext.delete(game)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem {
                        Button(action: { showingSheet.toggle() }) {
                            Label("Add a new game", systemImage: "plus")
                        }
                        .sheet(isPresented: $showingSheet) {
                            CreateGameSheetView()
                                .modelContext(modelContext)
                        }
                    }
                }
                .navigationTitle("game-title-string")
            }
            .tabItem {
                Label("game-title-string", systemImage: "pencil.and.list.clipboard")
            }
            
            PlayersView()
                .modelContext(modelContext)
                .tabItem {
                    Label("player-title-string", systemImage: "person.3.fill")
                }
            
            LeaderboardView(bestPlayers: bestPlayers, rotation: 0.0)
                .modelContext(modelContext)
                .tabItem {
                    Label("leaderboard-title-string", systemImage: "trophy.fill")
                }
        }
        .onAppear(perform: {
            resetPlayerSelection()
            if players.count > 1 && gameItems.count > 0 {
                requestReview()
            }
            bestPlayers = getBestPlayers()
        })
    }
    
    private func getBestPlayers() -> [Player] {
        let sortedPlayers = players.sorted { $0.numberOfGameWon > $1.numberOfGameWon }
        return Array(sortedPlayers.prefix(3))
    }
    
    private func requestReview() {
        ReviewRequestManager.shared.requestReviewIfAppropriate()
    }
    
    private func resetPlayerSelection() {
        players.forEach { player in
            player.currentlySelected1 = false
            player.currentlySelected2 = false
            player.currentlySelected3 = false
        }
    }
}

struct GameRowView: View {
    let game: Game
    
    var body: some View {
        HStack {
            Image(systemName: game.isGameConcluded ? "flag.checkered.circle" : "play.circle")
                .font(.title2)
            
            Text(getGameTitle(for: game))
        }
        .padding(.top, 15)
    }
    
    private func getGameTitle(for game: Game) -> String {
        let squad1 = game.squad1.joined(separator: " & ")
        let squad2 = game.squad2.joined(separator: " & ")
        let squad3 = game.squad3.first != "nil" ? game.squad3.joined(separator: " & ") : nil
        
        if let squad3 = squad3 {
            return "\(squad1) vs \(squad2) vs \(squad3)"
        } else {
            return "\(squad1) vs \(squad2)"
        }
    }
}
