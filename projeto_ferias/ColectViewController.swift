//
//  ColectViewController.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 22/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import SpriteKit

class ColectViewController: UIViewController {
    
    private var scene: ColectGameScene!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
        
            scene = ColectGameScene(size: self.view.frame.size)
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
            
            let exitButton = UIButton();
            exitButton.setImage(UIImage(named: "out"), for: .normal)
            exitButton.frame = CGRect(x: self.view.frame.width*0.9, y: (self.view.frame.width*0.1)-46, width: 46, height: 46)
            exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
            self.view.addSubview(exitButton)
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
        scene.producingForms = false
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
