//
//  MenuView.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 28/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import SceneKit

class MenuView: SCNView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.scene = MenuScene(coder: aDecoder)
    }
    
}
