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
    //TODO: pick winner after hand points insertion, set the winner a win, the loser(s) a lost game, update win ratio accordingly.
    //TODO: tell the user which one has to be dealer
    
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
