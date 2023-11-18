//
//  burracopointsApp.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import SwiftUI
import SwiftData

@main
struct burracopointsApp: App {
    //pick winner after hand points insertion, set the winner a win, the loser(s) a lost game,
    
    //TODO: update win ratio accordingly.

    //TODO: tell the user which one has to be dealer
    
    //TODO: sort games by time: most recent ones on top, divide them by finished and not
    
    //TODO: after the creation of a game consider opening the game detailed view instead of the games section
    
    //TODO: username costraints
    
    //TODO: fix wins
    
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
           Game.self,
           Player.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    
                })
        }
        .modelContainer(sharedModelContainer)
    }
}
