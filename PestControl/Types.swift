//
//  Types.swift
//  PestControl
//
//  Created by Bernardo Sarto de Lucena on 4/22/18.
//  Copyright © 2018 Bernardo Sarto de Lucena. All rights reserved.
//

import Foundation

// This defines all directions in which a character is allowed to move.
enum Direction: Int {
    case forward = 0, backward, left, right
}

typealias TileCoordinates = (column: Int, row: Int)

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let All: UInt32 = 0xFFFFFFFF
    static let Edge: UInt32 = 0b1
    static let Player: UInt32 = 0b10
    static let Bug: UInt32 = 0b100
    static let Firebug: UInt32 = 0b1000
    static let Breakable: UInt32 = 0b10000
}
