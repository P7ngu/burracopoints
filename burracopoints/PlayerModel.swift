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
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
    
}

