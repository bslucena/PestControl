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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        background = childNode(withName: "background") as! SKTileMapNode
    }
}
