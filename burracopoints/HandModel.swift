//
//  HandModel.swift
//  burracopoints
//
//  Created by Matteo Perotta on 14/11/23.
//

import Foundation
import SwiftData

@Model
class Hand{
    
    var currentDealer: Player

    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
    
}
