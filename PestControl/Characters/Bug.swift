//
//  Bug.swift
//  PestControl
//
//  Created by Bernardo Sarto de Lucena on 4/22/18.
//  Copyright © 2018 Bernardo Sarto de Lucena. All rights reserved.
//

import SpriteKit

enum BugSettings {
    static let bugDistance: CGFloat = 16
}

class Bug: SKSpriteNode {
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    var animations: [SKAction] = []
    
    init() {
        let texture = SKTexture(pixelImageNamed: "bug_ft1")
        super.init(texture: texture, color: .white,
                   size: texture.size())
        name = "Bug"
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        physicsBody?.restitution = 0.5
        physicsBody?.allowsRotation = false
        createAnimations(character: "bug")
        
    }
    
    func move() {
        // Here you create a vector with a random direction. Each component of the vector can be 0, bugDistance, or -bugDistance.
        let randomX = CGFloat(Int.random(min: -1, max: 1))
        let randomY = CGFloat(Int.random(min: -1, max: 1))
        
        let vector = CGVector(dx: randomX * BugSettings.bugDistance, dy: randomY * BugSettings.bugDistance)
        
        // You create a moveBy action for the bug with this vector, and a second action to call move() again.
        let moveBy = SKAction.move(by: vector, duration: 1)
        let moveAgain = SKAction.run(move)
        
        // First, you determine the animation direction using the animationDirection(for:) from Animatable.
        let direction = animationDirection(for: vector)
        // Then, if the direction is right, scale the bug so it appears to be going right.
        if direction == .left {
            xScale = abs(xScale)
        } else if direction == .right {
            xScale = -abs(xScale)
        }
        // Finally, run the appropriate animation action and kick off the sequence of move actions. The bug will perform the move, and then repeat move() indefinitely.
        run(animations[direction.rawValue], withKey: "animation")
        run(SKAction.sequence([moveBy, moveAgain]))
    }
}

extension Bug : Animatable {}
