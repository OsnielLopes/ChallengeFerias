//
//  Geometries.swift
//  projeto_ferias
//
//  Created by Osniel Lopes Teixeira on 10/01/2018.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

struct Geometries {
    
    static private let simetryGameForms: [String:String] = ["retangulo":"quadrado", "triangulo":"quadrado","quadrado":"retângulo","meio_circulo":"círculo"]
    static private let colectGameForms: [String:String] = ["quadrado":"quadrado", "triangulo":"triângulo","retangulo":"retângulo","circulo":"círculo"]
    
    ///Returns the key to the dictionary of the forms, the key is also the name of the respective asset
    static func getFormKey(_ gameType: GameType) -> String {
        switch gameType {
        case .simetry:
            return simetryGameForms.randomKey()
        case .colect:
            return colectGameForms.randomKey()
        }
    }
    
    static func getFormName(gameType: GameType, key: String) -> String {
        switch gameType {
        case .simetry:
            return simetryGameForms[key]!
        case .colect:
            return colectGameForms[key]!
        }
        
    }
    
}

enum GameType{
    case simetry
    case colect
}
