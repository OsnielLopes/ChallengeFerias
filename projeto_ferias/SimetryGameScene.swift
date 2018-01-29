//
//  GameScene.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 08/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var geometries = [Geometry]()
    private var width: CGFloat!
    private var height: CGFloat!
    private var answerNode: SKSpriteNode!
    private var answerFormKey: String!
    private let answerCategory: UInt32 = 0x1 << 0
    private let formCategory: UInt32 = 0x1 << 1
    private var labelNode: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        self.width = self.frame.width
        self.height = self.frame.height
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        self.answerFormKey = Geometries.getFormKey(.simetry)
        
        if let label = self.childNode(withName: "label") as? SKLabelNode {
            self.labelNode = label
            label.text = label.text! + Geometries.getFormName(gameType: .simetry, key: answerFormKey)
            label.position.x = 0
        }
        
        var formKeys = [String]()
        formKeys.append(answerFormKey)
        for _ in 0...1 {
            formKeys.append(Geometries.getFormKey(.simetry))
        }
        formKeys.shuffle()
        
        var count = 0
        self.enumerateChildNodes(withName: "geometry[1-3]") { (node, stop) in
            let formKey = formKeys[count]
            let texture = SKTexture(imageNamed: formKey)
            let size = CGSize(width: self.width*0.1, height: self.width*0.1)
            let geometry = Geometry(texture: texture, color: .white, size: size)
            geometry.name = formKey
            geometry.position = node.position
            geometry.physicsBody = SKPhysicsBody(texture: texture, size: size)
            geometry.physicsBody?.usesPreciseCollisionDetection = true
            if formKey == self.answerFormKey {
                geometry.physicsBody?.categoryBitMask = self.formCategory
            }
            geometry.physicsBody?.allowsRotation = false
            self.addChild(geometry)
            self.geometries.append(geometry)
            node.removeFromParent()
            count += 1
        }
        
        let node = self.childNode(withName: "geometry4")
        let texture = SKTexture(imageNamed: answerFormKey+"_invertida")
        let size = CGSize(width: self.width*0.1, height: self.width*0.1)
        self.answerNode = Geometry(texture: texture, color: .white, size: size)
        answerNode.name = answerFormKey
        answerNode.position = CGPoint(x: answerNode.size.width/2, y: 0)
        answerNode.physicsBody = SKPhysicsBody(texture: texture, size: size)
        answerNode.physicsBody?.usesPreciseCollisionDetection = true
        answerNode.physicsBody?.categoryBitMask = self.answerCategory
        answerNode.physicsBody?.contactTestBitMask = self.formCategory
        answerNode.physicsBody?.allowsRotation = false
        self.addChild(answerNode)
        node?.removeFromParent()
        
        //setting the axis of symmetry
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: -self.width*0.15))
        path.addLine(to: CGPoint(x: 0, y: self.width*0.15))
        let axis = SKShapeNode(path: path)
        axis.name = "axisNode"
        axis.lineWidth = 1
        axis.strokeColor = .white
        self.addChild(axis)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if pos.x <= 0 {
            for geometry in geometries {
                if geometry.contains(pos){
                    geometry.isMoving = true
                    geometry.lastTouch = pos
                }
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        for geometry in geometries {
            if geometry.isMoving {
                if geometry.lastTouch != nil {
                    let deltaX = pos.x - geometry.lastTouch.x
                    if geometry.position.x + deltaX + geometry.size.width/2 <= 0 {
                        let deltaY = pos.y - geometry.lastTouch.y
                        let move = SKAction.moveBy(x: deltaX, y: deltaY, duration: 0.0001)
                        geometry.run(move)
                        geometry.lastTouch = pos
                    }
                }
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        for geometry in geometries {
            geometry.isMoving = false
        }
        let action = SKAction.move(to: CGPoint(x: self.answerNode.size.width/2, y: 0), duration: 0.5)
        self.answerNode.run(action)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        for geometry in geometries {
            if abs(geometry.position.x) < geometry.size.width/2 {
                geometry.position.x = 0 - geometry.size.width/2
            }
        }
    }
    
    //MARK: SKPhysicsContactDelegate Methods
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        if nodeA?.name == nodeB?.name {
            self.won((nodeA?.position)!, (nodeB?.position)!)
        }
    }
    
    //MARK: Auxiliar Functions
    func won(_ position1: CGPoint, _ position2: CGPoint){
        if let axixNode = self.childNode(withName: "axisNode") {
            axixNode.removeFromParent()
        }
        for g in geometries {
            if g.position != position1 && g.position != position2 {
                let action = SKAction(named: "Disappear")
                g.run(action!)
            } else {
                let action1 = SKAction.move(to: CGPoint(x: -self.height*0.5/2, y: 0), duration: 2)
                let action2 = SKAction.resize(toWidth: self.height*0.5, height: self.height*0.5, duration: 2)
                let action3 = SKAction.move(to: CGPoint(x: self.height*0.5/2, y: 0), duration: 2)
                
                let group1 = SKAction.group([action1, action2])
                g.run(group1)
                
                let group2 = SKAction.group([action3, action2])
                self.answerNode.run(group2)
                
                self.labelNode.text = "Parabéns!"
            }
        }
        
    }
    
}
