//
//  MemoryViewController.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 30/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import SpriteKit

class MemoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            
            let scene = MemoryScene(size: self.view.frame.size)
            
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func exitButtonPressed(){
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
