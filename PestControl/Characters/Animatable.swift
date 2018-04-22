//
//  Animatable.swift
//  PestControl
//
//  Created by Bernardo Sarto de Lucena on 4/22/18.
//  Copyright © 2018 Bernardo Sarto de Lucena. All rights reserved.
//

import SpriteKit

// All characters conforming to Animatable will have a different animation depending upon their direction. Protocols assume that conforming types may have value semantics (i.e. structures and enumerations) which would make animations immutable. In this situation, the Characters (Player and Bug) are the only classes which will conform to Animatable and, being classes, they have reference semantics. So you can safely inform Animatable that only class types will conform.
protocol Animatable: class {
    
    // This property will hold the character’s animations, and each class that conforms to this protocol will need to define this property.
    var animations: [SKAction] { get set }
    
}

//  By creating a method in a protocol extension, you can provide a default method to calculate this direction.
// This method takes in a vector and returns the direction of this vector — forward, backward, left or right. It does so by determining whether the x-component or y- component of the vector is greater, and if that component is positive or negative. A bigger, negative x-component means that the direction is towards the left, and a bigger, negative y-component means down, which in this case, is forward.
extension Animatable {
    func animationDirection(for directionVector: CGVector) -> Direction {
        let direction: Direction
        if abs(directionVector.dy) > abs(directionVector.dx) {
            direction = directionVector.dy < 0 ? .forward : .backward
        } else {
            direction = directionVector.dx < 0 ? .left : .right
        }
        return direction
    }
    
    func createAnimations(character: String) {
        let actionForward: SKAction = SKAction.animate(with: [SKTexture(imageNamed: "\(character)_ft1"), SKTexture(imageNamed: "\(character)_ft2")], timePerFrame: 0.2)
        animations.append(SKAction.repeatForever(actionForward))
        
        
        let actionBackward: SKAction = SKAction.animate(with: [SKTexture(imageNamed: "\(character)_bk1"), SKTexture(imageNamed: "\(character)_bk2")], timePerFrame: 0.2)
        animations.append(SKAction.repeatForever(actionBackward))
        let actionLeft: SKAction = SKAction.animate(with: [SKTexture(imageNamed: "\(character)_lt1"), SKTexture(imageNamed: "\(character)_lt2")], timePerFrame: 0.2)
        animations.append(SKAction.repeatForever(actionLeft))
        animations.append(SKAction.repeatForever(actionLeft))
    }
}
