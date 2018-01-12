//
//  Geometry.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 09/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import SpriteKit

class Geometry: SKSpriteNode {
    
    var isMoving = false
    var lastTouch: CGPoint!
    
    init(texture: SKTexture, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color,   size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
