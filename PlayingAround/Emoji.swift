//
//  Emoji.swift
//  PlayingAround
//
//  Created by Antony Holshouser on 12/31/24.
//

import Foundation

@Observable
class Emoji: Identifiable {
    let id = UUID()
    
    let emoji: String
    var x: Double
    var y: Double
    var xVelocity: Double
    var yVelocity: Double
    
    init(emoji: String, x: Double, y: Double, xVelocity: Double, yVelocity: Double) {
        self.emoji = emoji
        self.x = x
        self.y = y
        self.xVelocity = xVelocity
        self.yVelocity = yVelocity
    }
}
