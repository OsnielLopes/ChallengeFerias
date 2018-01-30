//
//  File.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 30/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import SpriteKit

class MemoryScene: SKScene {
    
    private var width: CGFloat!
    private var height: CGFloat!
    private var cardSize: CGSize!
    private var cards = [CardSKNode]()
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        
        self.width = size.width
        self.height = size.height
        
        self.cardSize = CGSize(width: height*0.2187, height: height*0.35)
        
        let cardsPositions: [CGPoint] = [
            CGPoint(x: width/4, y: height*0.275),
            CGPoint(x: width/4*2, y: height*0.275),
            CGPoint(x: width/4*3, y: height*0.275),
            CGPoint(x: width/4, y: height*0.725),
            CGPoint(x: width/4*2, y: height*0.725),
            CGPoint(x: width/4*3, y: height*0.725)
        ]
        
        var cardsAssetNames: [String] = [
            "carta_cone",
            "carta_conec",
            "carta_cubo",
            "carta_cuboc",
            "carta_paralelepipedo",
            "carta_paralelepipedoc"
        ]
        
        cardsAssetNames.shuffle()
        
        for i in 0..<cardsPositions.count {
            let point = cardsPositions[i]
            let assetName = cardsAssetNames[i]
            let texture = SKTexture(imageNamed: "tras")
            let card = CardSKNode(texture: texture, color: .white, size: cardSize)
            card.name = assetName
            card.position = point
            self.addChild(card)
            cards.append(card)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Touch functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        for node in cards {
            if node.contains(pos) && !node.matched{
                let texture: SKTexture!
                if node.isTurned {
                    texture = SKTexture(imageNamed: "tras")
                } else {
                    texture = SKTexture(imageNamed: node.name!)
                    
                }
                node.texture = texture
                node.isTurned = !node.isTurned
            }
        }
        let turnedCards = cards.filter({ (card) -> Bool in
            return card.isTurned
        })
        if turnedCards.count == 6 {
            self.won()
        } else {
            let turnedCardsNotMatched = turnedCards.filter({ (card) -> Bool in
                return !card.matched
            })
            if turnedCardsNotMatched.count == 2 {
                if let cardAName = turnedCardsNotMatched[0].name, let cardBName = turnedCardsNotMatched[1].name {
                    if !cardAName.contains(cardBName) && !cardBName.contains(cardAName) {
                        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (t) in
                            for card in turnedCardsNotMatched {
                                card.texture = SKTexture(imageNamed: "tras")
                                card.isTurned = false
                            }
                        })
                    } else {
                        for card in turnedCardsNotMatched {
                            card.matched = true
                        }
                    }
                }
            }
        }
        
    }
    
    //MARK: Auxiliar Functions
    private func won(){
        let getOut = SKAction.init(named: "Disappear")
        let wait = SKAction.wait(forDuration: 1)
        let actions = SKAction.sequence([wait,getOut!])
        for card in cards {
            card.run(actions, completion: {
                card.removeFromParent()
            })
        }
        let endGameLabel = SKLabelNode(text: "Parabéns!")
        endGameLabel.position = CGPoint(x: width/2, y: height/2)
        endGameLabel.fontName = "Futura Medium"
        endGameLabel.fontSize = 30
        endGameLabel.horizontalAlignmentMode = .center
        endGameLabel.alpha = 0
        self.addChild(endGameLabel)
        let appear = SKAction.fadeAlpha(to: 1, duration: 2)
        endGameLabel.run(appear)
        
    }
}
