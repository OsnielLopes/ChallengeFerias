//
//  ColectGameScene.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 22/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import SpriteKit

class ColectGameScene: SKScene {
    
    private var timer: Timer!
    private var timeInterval: TimeInterval = 1
    private var width: CGFloat!
    private var height: CGFloat!
    private var time: TimeInterval = 20
    private var initialTime: TimeInterval?
    private var currentTime: TimeInterval!
    var producingForms = true
    private var wantedFormKey: String = Geometries.getFormKey(.colect)
    private var wantedFormName: String!
    private var wantedFormLabel: SKLabelNode!
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        self.wantedFormName = Geometries.getFormName(gameType: .colect, key: wantedFormKey)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        self.physicsWorld.speed = 0.9999
        
        self.backgroundColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1)
        
        self.width = size.width
        self.height = size.height
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            self.createAnForm()
        }
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false) { (timer) in
            self.createAnForm()
        }
        Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false) { (timer) in
            self.createAnForm()
        }
        
        //creates the label
        wantedFormLabel = SKLabelNode(text: "Colete "+wantedFormName+"s")
        wantedFormLabel.position = CGPoint(x: width*0.85, y: height/2)
        wantedFormLabel.fontName = "Futura Medium"
        wantedFormLabel.fontSize = 20
        wantedFormLabel.horizontalAlignmentMode = .center
        wantedFormLabel.zPosition = 5
        self.addChild(wantedFormLabel)
        
        //creates the hearts
        for i in 0...2 {
            let heart = SKSpriteNode(imageNamed: "heart")
            heart.size = CGSize(width: width*0.05, height: width*0.05)
            let percentageOfTheWidth = width*0.725
            let valueOfSpaces = CGFloat(i+1)*width*0.0666
            let xValue = percentageOfTheWidth + valueOfSpaces
            heart.position = CGPoint(x: xValue, y: height*0.25)
            heart.name = "heart\(i)"
            heart.zPosition = 5
            self.addChild(heart)
        }
        
        //setting the separator
        let path = CGMutablePath()
        path.move(to: CGPoint(x: width*0.70, y: 0))
        path.addLine(to: CGPoint(x: width*0.70, y: self.height))
        let axis = SKShapeNode(path: path)
        axis.name = "separator"
        axis.lineWidth = 2
        axis.strokeColor = .white
        self.addChild(axis)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if Int(currentTime)%2 == 0 {
            for node in self.children {
                if !self.contains(node.convert(node.position, to: self)) && node.position.y < 0 && !node.isKind(of: SKLabelNode.self){
                    if node.name == wantedFormKey {
                        removeAHeart()
                    }
                    node.removeFromParent()
                }
            }
        }
        if initialTime == nil {
            initialTime = currentTime
        } else
            if currentTime - initialTime! > time {
                createAnForm()
                time += 20
        }
        self.currentTime = currentTime
    }
    
    //MARK: Touch functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        for node in self.children.filter({ (node) -> Bool in
            node.position.x <= width*0.6
        }){
            if node.name == wantedFormKey && node.contains(pos){
                node.removeFromParent()
            } else if node.contains(pos) {
                removeAHeart()
            }
        }
    }
    
    //MARK: Aux Functions
    
    @objc func createAnForm(){
        
        if self.producingForms {
            
            let nodeFormKey = Geometries.getFormKey(.colect)
            let texture = SKTexture(imageNamed: nodeFormKey)
            let size = CGSize(width: self.width*0.1, height: self.width*0.1)
            let node = SKSpriteNode(texture: texture, color: .white, size: size)
            node.name = nodeFormKey
            let xPos:CGFloat = {
                var pos: CGFloat!
                var count = 0
                repeat {
                    pos = CGFloat(arc4random_uniform(UInt32(Int(self.width*0.55))))+self.width*0.05
                    count += 1
                    if count > 1000 {break}
                } while !(self.isCreatable(pos))
                return pos
            }()
            node.position = CGPoint(x: xPos, y: self.height+self.width*0.1)
            node.physicsBody = SKPhysicsBody(texture: texture, size: size)
            node.physicsBody?.allowsRotation = false
            node.zPosition = 10
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(createAnForm), userInfo: nil, repeats: false)
            timeInterval = TimeInterval((arc4random_uniform(3000)+1000)/1000)
            self.addChild(node)
        }
    }
    
    func nodesOnTheTopHalfOfTheScreen() -> [SKNode]{
        var nodes = [SKNode]()
        for node in self.children {
            if node.position.y >= 0 {
                nodes.append(node)
            }
        }
        return nodes
    }
    
    func isCreatable(_ pos: CGFloat) -> Bool {
        for node in self.nodesOnTheTopHalfOfTheScreen() {
            if node.position.x > pos - self.width*0.05 && node.position.x < pos + self.width*0.05{
                return false
            }
        }
        return true
    }
    
    func removeAHeart() {
        let heartNodes = self.children.filter({ (node) -> Bool in
            if let nodeName = node.name {
                return nodeName.contains("heart")
            }
            return false
        })
        if heartNodes.count > 1 {
            heartNodes.first?.removeFromParent()
        } else if heartNodes.count == 1 {
            heartNodes.first?.removeFromParent()
            self.producingForms = false
            gameOver()
        }
    }
    
    func gameOver(){
        
        wantedFormLabel.removeFromParent()
        if let separator = self.childNode(withName: "separator"){
            separator.removeFromParent()
        }
        
        let endGameLabel = SKLabelNode(text: "Fim de Jogo!")
        endGameLabel.position = CGPoint(x: width/2, y: height+20)
        endGameLabel.fontName = "Futura Medium"
        endGameLabel.fontSize = 30
        endGameLabel.horizontalAlignmentMode = .center
        self.addChild(endGameLabel)
        
        let time = Int(self.currentTime)-Int(self.initialTime!)
        let text = "Pontuação: \(time)"
        let pontuationLabel = SKLabelNode(text: text)
        pontuationLabel.position = CGPoint(x: width/2, y: -20)
        pontuationLabel.fontName = "Futura Medium"
        pontuationLabel.fontSize = 30
        pontuationLabel.horizontalAlignmentMode = .center
        self.addChild(pontuationLabel)
        
        let downAction = SKAction.moveTo(y: (height/2)+25, duration: 1)
        let upAction = SKAction.moveTo(y: (height/2)-25, duration: 1)
        
        endGameLabel.run(downAction)
        pontuationLabel.run(upAction)
    }
    
    
    
}
