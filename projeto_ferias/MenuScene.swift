//
//  MenuScene.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 28/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    private var width: CGFloat!
    private var height: CGFloat!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1)
        
        self.addAForm()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addAForm()
        
    }
    
    @objc func addAForm(){
        let nodeFormKey = Geometries.getFormKey(.colect)
        let texture = SKTexture(imageNamed: nodeFormKey)
        let size = CGSize(width: self.frame.width*0.1, height: self.frame.width*0.1)
        let node = SKSpriteNode(texture: texture, color: .white, size: size)
        node.name = nodeFormKey
        let xPos: CGFloat = CGFloat(arc4random_uniform(UInt32(self.frame.width)))
        let yPos: CGFloat = CGFloat(arc4random_uniform(UInt32(self.frame.height)))
        node.position = CGPoint(x: xPos, y: yPos)
        node.alpha = 0
        self.addChild(node)
        
        let makeItVisible = SKAction.fadeAlpha(to: 0.9, duration: 10)
        
        let newXPos: CGFloat = CGFloat(arc4random_uniform(UInt32(self.frame.width)))
        let newYPos: CGFloat = CGFloat(arc4random_uniform(UInt32(self.frame.height)))
        
        let move = SKAction.move(to: CGPoint(x: newXPos, y: newYPos), duration: 20)
        let goAway = SKAction.fadeAlpha(to: 0, duration: 10)
        
        let apearDesapear = SKAction.sequence([makeItVisible,goAway])
        
        let animation  = SKAction.group([move, apearDesapear])
        node.run(animation) {
            node.removeFromParent()
        }
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addAForm), userInfo: nil, repeats: false)
    }
    
}
