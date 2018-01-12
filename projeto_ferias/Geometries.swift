//
//  Geometries.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 10/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

struct Geometries {
    
    static private let forms: [String:String] = ["quadrado":"quadrado", "triangulo":"quadrado","retangulo":"retangulo","circulo":"círculo"]
    
    ///Returns the key to the dictionary of the forms, the key is also the name of the respective asset
    static func getFormKey() -> String {
        return forms.randomKey()
    }
    
    static func getFormName(asset key: String) -> String {
        return forms[key]!
    }
}
