//
//  Extensions.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 10/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle() {
        var last = self.count - 1
        while(last > 0) {
            let rand = Int(arc4random_uniform(UInt32(last)))
            self.swapAt(last, rand)
            last -= 1
        }
    }
}

extension Dictionary {
    func randomKey() -> Key {
        let index: Int = Int(arc4random_uniform(UInt32(self.count)))
        return Array(self.keys)[index]
    }
}
