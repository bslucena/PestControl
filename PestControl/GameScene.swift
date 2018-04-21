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
        
        // Assign that constraint to the camera, so the camera will always follow the player and keep him centered onscreen.
        camera.constraints = [playerConstraint]
    }
}
