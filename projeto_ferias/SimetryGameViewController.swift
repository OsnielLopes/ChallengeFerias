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
            
            
            let exitButton = UIButton();
            exitButton.setImage(UIImage(named: "out"), for: .normal)
            exitButton.frame = CGRect(x: self.view.frame.width*0.9, y: (self.view.frame.width*0.1)-46, width: 46, height: 46)
            exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
            self.view.addSubview(exitButton)
            
            let helpButton = UIButton()
            helpButton.setImage(UIImage(named: "question"), for: .normal)
            helpButton.frame = CGRect(x: self.view.frame.width*0.9, y: self.view.frame.height-(self.view.frame.width*0.1), width: 46, height: 46)
            helpButton.addTarget(self, action: #selector(helpButtonPressed), for: .touchUpInside)
            self.view.addSubview(helpButton)
            
            
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
    @objc func exitButtonPressed(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func helpButtonPressed(sender: UIButton!) {
        let alert = UIAlertController(title: "Ajuda", message: "Una alguma das peças à direita com a forma do centro para criar a forma solicitada.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
