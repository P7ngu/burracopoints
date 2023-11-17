//
//  PlayerModel.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import Foundation
import SwiftData

@Model
class Player {
    var name: String
    var icon: String
    var currentlySelected1: Bool
    var currentlySelected2: Bool
    var currentlySelected3: Bool
    var numberOfGamePlayed: Int
    var numberOfGameWon: Int
    var winRatio: Float
    
    init(name: String, icon: String, currentlySelected1: Bool, currentlySelected2: Bool, currentlySelected3: Bool, numberOfGamePlayed: Int, numberOfGameWon: Int, winRatio: Float) {
        self.name = name
        self.icon = icon
        self.currentlySelected1 = currentlySelected1
        self.currentlySelected2 = currentlySelected2
        self.currentlySelected3 = currentlySelected3
        self.numberOfGamePlayed = numberOfGamePlayed
        self.numberOfGameWon = numberOfGameWon
        self.winRatio = winRatio
    }
    
}

