//
//  Extensions.swift
//  PestControl
//
//  Created by Bernardo Sarto de Lucena on 4/22/18.
//  Copyright © 2018 Bernardo Sarto de Lucena. All rights reserved.
//

import SpriteKit

extension SKTexture {
    convenience init(pixelImageNamed: String) {
        self.init(imageNamed: pixelImageNamed)
        self.filteringMode = .nearest
    }
}
