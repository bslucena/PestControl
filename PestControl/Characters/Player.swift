//
//  Player.swift
//  PestControl
//
//  Created by Bernardo Sarto de Lucena on 4/8/18.
//  Copyright © 2018 Bernardo Sarto de Lucena. All rights reserved.
//

import CoreGraphics
import Foundation
import SpriteKit

enum PlayerSettings {
    static let playerSpeed: CGFloat = 280.0
}

class Player: SKSpriteNode {
    
    // Player needs to conform to Animatable
    var animations: [SKAction] = []
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init() {
        let texture = SKTexture(pixelImageNamed: "player_ft1")
        super.init(texture: texture, color: .white,
                   size: texture.size())
        name = "Player"
        zPosition = 50
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.restitution = 1.0
        physicsBody?.linearDamping = 0.5
        physicsBody?.friction = 0
        physicsBody?.allowsRotation = false
        createAnimations(character: "player")
    }
    
    func move(target: CGPoint) {
        guard let physicsBody = physicsBody else { return }
        
        let newVelocity = (target - position).normalized()
            * PlayerSettings.playerSpeed
        physicsBody.velocity = CGVector(point: newVelocity)
        print("* \(animationDirection(for: physicsBody.velocity))")
        checkDirection()
    }
    
    func checkDirection() {
        guard let physicsBody = physicsBody else { return }
        // You calculate the direction from the player’s velocity using Animatable’s default implementation.
        let direction = animationDirection(for: physicsBody.velocity)
        
        // If the direction is returned as right, you set the player’s xScale to negative so that the left animation is reversed.
        if direction == .left {
            xScale = abs(xScale)
        }
        if direction == .right {
            xScale = -abs(xScale)
        }
        
        // You run the appropriate animation for the direction
        run(animations[direction.rawValue], withKey: "animation")
    }
}

// Player conforms to Animatable
extension Player : Animatable {}


