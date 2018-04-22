//
//  Animatable.swift
//  PestControl
//
//  Created by Bernardo Sarto de Lucena on 4/22/18.
//  Copyright © 2018 Bernardo Sarto de Lucena. All rights reserved.
//

import SpriteKit

// All characters conforming to Animatable will have a different animation depending upon their direction.
protocol Animatable {
    
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
}
