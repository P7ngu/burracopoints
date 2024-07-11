import SwiftUI
import SwiftData

struct LeaderboardView: View {
    @Query var allPlayers: [Player]
    @State var bestPlayers: [Player] = []
    @State var rotation: CGFloat = 0.0
    @State var trigger = 0
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationView {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(width: 270, height: 350)
                    .foregroundColor(Color("L"))
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(width: 140, height: 520)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("L"), Color("L")]), startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.degrees(rotation))
                    .mask {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(lineWidth: 12)
                            .frame(width: 266, height: 346)
                    }
                
                VStack {
                    if bestPlayers.count > 0 {
                        LeaderboardEntryView(player: bestPlayers.first!, color: .yellow, position: "1st")
                    }
                    if bestPlayers.count > 1 {
                        LeaderboardEntryView(player: bestPlayers[1], color: .gray, position: "2nd")
                    }
                    if bestPlayers.count > 2 {
                        LeaderboardEntryView(player: bestPlayers[2], color: .orange, position: "3rd")
                    }
                }
            }
            .onAppear {
                bestPlayers = getBestPlayers(from: allPlayers)
                trigger += 1
                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
            .navigationTitle("leaderboard-title-string")
        }
    }
    
    private func getBestPlayers(from players: [Player]) -> [Player] {
        // Sort the players by the number of games won
        return players.sorted { $0.numberOfGameWon > $1.numberOfGameWon }
    }
}

struct LeaderboardEntryView: View {
    var player: Player
    var color: Color
    var position: String
    
    var body: some View {
        VStack {
            Image(systemName: "trophy.circle.fill")
                .foregroundStyle(Color("T"), color)
                .font(.system(.largeTitle))
                .symbolEffect(.bounce, value: position)
            Text(player.name).bold().padding()
        }
    }
}


