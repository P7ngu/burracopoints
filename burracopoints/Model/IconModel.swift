//
//  IconModel.swift
//  burracopoints
//
//  Created by Matteo Perotta on 16/11/23.
//

import Foundation
import SwiftUI

class Icon: Identifiable{
    var name: String = ""
    var id: UUID
    @State var isSelected: Bool
    var color = Color.black
    
    init(name: String, id: UUID, isSelected: Bool, color: Color) {
        self.name = name
        self.id = id
        self.isSelected = isSelected
        self.color = color
    }
}
