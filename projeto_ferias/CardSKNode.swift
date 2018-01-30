//
//  File.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 30/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import SpriteKit

class CardSKNode: SKSpriteNode {
    
    var isTurned: Bool = false
    var matched: Bool = false
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
