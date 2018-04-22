//
//  GameScene.swift
//  PestControl
//
//  Created by Bernardo Sarto de Lucena on 4/8/18.
//  Copyright © 2018 Bernardo Sarto de Lucena. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var background: SKTileMapNode!
    var player = Player()
    
    override func didMove(to view: SKView) {
        addChild(player)
        setupCamera()
        setupWorldPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        background = childNode(withName: "background") as! SKTileMapNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        // This method takes the touch location and sends it to the move(target:) method of Player.
        player.move(target: touch.location(in: self))
    }
    
    func setupCamera() {
        
        // Check that the scene has a camera assigned to it.
        guard let camera = camera else { return }
        
        // Create a constraint to keep zero distance to the player.
        let zeroDistance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(zeroDistance, to: player)
        
        // First, you determine the smallest distance from each edge that you can position the camera to avoid showing the gray area. However, in the event the camera viewport is larger than the map — when it’s impossible to avoid showing the gray area — you take the minimum of that distance and half the background width/height. That way the map will stay centered.
        let xInset = min((view?.bounds.width)!/2 * camera.xScale, background.frame.width/2)
        let yInset = min((view?.bounds.height)!/2 * camera.yScale, background.frame.height/2)
        
        // Now that you know the smallest distance from each edge, you can use insetBy(dx:dy:) to get a rectangular boundary constraint.
        let constraintRect = background.frame.insetBy(dx: xInset, dy: yInset)
        
        // Then, you set up a constraint for x and y with lower and upper limits.
        let xRange = SKRange(lowerLimit: constraintRect.minX, upperLimit: constraintRect.maxX)
        let yRange = SKRange(lowerLimit: constraintRect.minY, upperLimit: constraintRect.maxY)
        
        let edgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        edgeConstraint.referenceNode = background
        
        // Assign that constraint to the camera, so the camera will always follow the player and keep him centered onscreen.
        // Finally, you constrain the camera with the player constraint first and the edge constraint second. The edge constraint has higher priority, so it goes last.

        camera.constraints = [playerConstraint, edgeConstraint]
    }
    
    func setupWorldPhysics() {
        // giving an edge loop physics body to the background tile map node, you make sure the player will never leave the map.
        background.physicsBody = SKPhysicsBody(edgeLoopFrom: background.frame)
    }
}
