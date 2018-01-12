//
//  GameViewController.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 08/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "SimetryGameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
            
            
            let button = UIButton();
            button.setImage(UIImage(named: "out"), for: .normal)
            button.frame = CGRect(x: self.view.frame.width*0.9, y: (self.view.frame.width*0.1)-46, width: 46, height: 46)
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            self.view.addSubview(button)
            
            
            
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: Auxiliar Functions
    @objc func buttonPressed(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
