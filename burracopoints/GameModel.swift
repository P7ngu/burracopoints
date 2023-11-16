//
//  Item.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import Foundation
import SwiftData

@Model
class Game{
    var timestamp: Date
    var maxPoints: Int
    
    // 1 vs 1, 1 vs 1 vs 1, 2 vs 2
    var gameMode: Int
    var playerCounter: Int
    var squad3Enabled: Bool = false
    
   var squad1: [String]
   var squad2: [String]

    var squad3: [String]
    
    var currentPoints_p1: Int
    var currentPoints_p2: Int
    var currentPoints_p3: Int
    
    var handPoints_p1: [Int]
    var handPoints_p2: [Int]
    var handPoints_p3: [Int]
    
    var handsPlayed: Int
    
    init(timestamp: Date, maxPoints: Int, gameMode: Int, playerCounter: Int, squad3Enabled: Bool, squad1: [String], squad2: [String], squad3: [String], currentPoints_p1: Int, currentPoints_p2: Int, currentPoints_p3: Int, handPoints_p1: [Int], handPoints_p2: [Int], handPoints_p3: [Int], handsPlayed: Int) {
        self.timestamp = timestamp
        self.maxPoints = maxPoints
        self.gameMode = gameMode
        self.playerCounter = playerCounter
        self.squad3Enabled = squad3Enabled
        
        self.squad1 = squad1
        self.squad2 = squad2
        self.squad3 = squad3
        
        self.currentPoints_p1 = currentPoints_p1
        self.currentPoints_p2 = currentPoints_p2
        self.currentPoints_p3 = currentPoints_p3
        
        self.handPoints_p1 = handPoints_p1
        self.handPoints_p2 = handPoints_p2
        self.handPoints_p3 = handPoints_p3
        
        self.handsPlayed = handsPlayed
    }
    
}
