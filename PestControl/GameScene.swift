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
    var bugsNode = SKNode()
    
    override func didMove(to view: SKView) {
        addChild(player)
        setupCamera()
        setupWorldPhysics()
        createBugs()
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
        // Here, you set the physics category of the map edge. You also set the game scene as the physics contact delegate to handle contact notifications.
        background.physicsBody?.categoryBitMask = PhysicsCategory.Edge
        physicsWorld.contactDelegate = self
    }
    
    // This method returns a tile definition at a row–column coordinate.
    func tile(in tileMap: SKTileMapNode, at coordinates: TileCoordinates) -> SKTileDefinition? {
        return tileMap.tileDefinition(atColumn: coordinates.column, row: coordinates.row)
    }
    
    func createBugs() {
        guard let bugsMap = childNode(withName: "bugs") as? SKTileMapNode else { return }
        
        // Cycle through the rows and columns of the tile map node.
        for row in 0..<bugsMap.numberOfRows {
            for column in 0..<bugsMap.numberOfColumns {
                // Get the tile definition at the row–column coordinate. If it’s not nil, then there must be a bug painted on that tile. You will use the tile variable shortly, but until then you’ll get a compiler warning.
                guard let tile = tile(in: bugsMap, at: (column, row)) else { continue }
                // Create a bug sprite node and get the center point of the tile to position the bug, and add the bug to the scene.
                let bug = Bug()
                bug.position = bugsMap.centerOfTile(atColumn: column, row: row)
                bugsNode.addChild(bug)
                bug.move()
            }
        }
        // Add bugsNode with all its child bugs to the scene.
        bugsNode.name = "Bugs"
        addChild(bugsNode)
        // Remove the tile map node from the scene as you no longer need it.
        bugsMap.removeFromParent()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func remove(bug: Bug) {
        bug.removeFromParent()
        // You’ll still remove the bug from its parent bugsNode, but then add it to background instead and call die(). The bug will be removed from background by the SKAction at the end of the die() sequence.
        background.addChild(bug)
        bug.die()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let other = contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyB : contact.bodyA
        
        switch other.categoryBitMask {
        case PhysicsCategory.Bug:
            if let bug = other.node as? Bug {
                remove(bug: bug)
            }
        default:
            break
        }
        
        // When any contact notification occurs — and remember, you are only listening for contacts involving the player — you check the direction of the player to ensure Arnie is animating in the correct direction. If he’s not moving at all, such as at the start of the game, do nothing.
        if let physicsBody = player.physicsBody {
            if physicsBody.velocity.length() > 0 {
                player.checkDirection()
            }
        }
    }
    
    
}















