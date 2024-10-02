//
//  burracopointsApp.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

//open /Applications/Xcode.app/Contents/MacOS/Xcode
//build: 18F132

import SwiftUI
import SwiftData

@main
struct burracopointsApp: App {
    
    //MARK: HIGH priority
    //TODO: manually pick winner, edit button for user
    //TODO: update win ratio accordingly.
    //TODO: tell the user which one has to be dealer, turn by turn
    //TODO: 155 / 2 = 75 or 80 lol
    //TODO: Display the winner's name, make the no you cannot add points view more cute
    
    //Future future updates
    //TODO: widget that shows points for the last game
    
    //MARK: DONE:
    // fix wins ____
    //sort games by time: most recent ones on top, divide them by finished and not
    //pick winner after hand points insertion, set the winner a win, the loser(s) a lost game,
    //after the creation of a game consider opening the game detailed view instead of the games section
    //username costraints
    //tell the user which one has to be dealer
    //FIX UNDO AFTER WIN.
    
    
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
                .modelContainer(sharedModelContainer)
                .onAppear(perform: {
                    
                })
        }
        .modelContainer(sharedModelContainer)
    }
}
