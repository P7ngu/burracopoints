//
//  IconSelectionView.swift
//  burracopoints
//
//  Created by Matteo Perotta on 26/02/24.
//

import SwiftUI

struct IconSelectionView: View {
    let icons = [
    Icon(name: "star.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "sun.max.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "person.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "heart.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "moon.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "cloud.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "bolt.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "snowflake.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "flame.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "theatermasks.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "popcorn.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "tortoise.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "lizard.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "bird.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "fish.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "tennisball.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "wind.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "toilet.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "sailboat.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "airplane.circle", id: UUID(), isSelected: false, color: Color.blue),
    Icon(name: "leaf.circle", id: UUID(), isSelected: false, color: Color.blue)
         ]
    
    @Binding var selectedIcon: String? // The currently selected icon
    
    var body: some View {
        // Using a LazyVGrid to create a grid layout for icon selection
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
            ForEach(icons) { icon in
                Image(systemName: icon.name) // Use your own icons. Replace `systemName` with `icon`
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding()
                    .background(self.selectedIcon == icon.name ? Color.green : Color.clear) // Highlight selected icon
                    .cornerRadius(8)
                    .onTapGesture {
                        self.selectedIcon = icon.name
                    }
            }
        }
        .padding()
    }
}
