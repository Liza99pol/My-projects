//
//  AnimationClass.swift
//  GameBat
//
//  Created by macbook m1 on 8.06.23.
//

import Foundation
import SpriteKit

class AnimationClass {
    func scaleZdirection(sprite: SKSpriteNode) {
        sprite.run(SKAction.repeatForever(SKAction.sequence([SKAction.scale(by: 1.7, duration: 0.5), SKAction.scale(to: 1.0, duration: 1.0)])))
    }
    
    func coinColorAnimation(sprite: SKSpriteNode, animDuration: TimeInterval) {
        sprite.run(SKAction.repeatForever(SKAction.sequence([SKAction.colorize(with: .orange, colorBlendFactor: 0.8, duration: animDuration), SKAction.colorize(withColorBlendFactor: 0.0, duration: animDuration)])))
    }
}
