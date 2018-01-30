//
//  MenuViewController.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 28/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import SpriteKit

class MenuViewController: UIViewController {

    @IBOutlet weak var simetryGameButton: UIButton!
    @IBOutlet weak var colectGameButton: UIButton!
    @IBOutlet weak var jogoDaMemoriaGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simetryGameButton.backgroundColor = UIColor.white
        colectGameButton.backgroundColor = UIColor.white
        jogoDaMemoriaGameButton.backgroundColor = UIColor.white
        
        simetryGameButton.tintColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1)
        simetryGameButton.titleLabel?.font = UIFont(name: "Futura-Medium", size: 20)
        simetryGameButton.layer.cornerRadius = 10
        simetryGameButton.clipsToBounds = true
        
        colectGameButton.tintColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1)
        colectGameButton.titleLabel?.font = UIFont(name: "Futura-Medium", size: 20)
        colectGameButton.layer.cornerRadius = 10
        colectGameButton.clipsToBounds = true
        
        jogoDaMemoriaGameButton.tintColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        jogoDaMemoriaGameButton.titleLabel?.font = UIFont(name: "Futura-Medium", size: 20)
        jogoDaMemoriaGameButton.layer.cornerRadius = 10
        simetryGameButton.clipsToBounds = true
        
        
        if let view = self.view as? SKView {
            let scene = MenuScene(size: self.view.frame.size)
            scene.scaleMode = .aspectFill
            
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
