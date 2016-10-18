//
//  Constans.swift
//  BrouryHunter
//
//  Created by Infraestructura on 01/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

struct Constans {
    // font sizes
    static let FUENTE_SIZE_TITULOS:CGFloat = 24.0
    static let FUENTE_SIZE_SUBTITULOS:CGFloat = 17.0
    static let FUENTE_SIZE_NORMAL:CGFloat = 14.0
    static let FUENTE_SIZE_SUB:CGFloat = 12.0
    
    // colores
    // 1 solido 0 transparente  
    // RGB (123,123,123)  ---- 128/255,   30/255    , 17/255
    static let FUENTE_COLOR_ETIQUETAS = UIColor(red: 0.1, green: 1.0, blue: 0.1, alpha: 1.0)
    static let FUENTE_COLOR_TEXTO = UIColor(red: 0.9, green: 0.2, blue: 0.5, alpha: 1.0)
    static let FUENTE_COLOR_NORMAL = UIColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 1.0)
    static let FUENTE_COLOR_SUB = UIColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0)
    static let FUENTE_COLOR_WHITE = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let FUENTE_COLOR_BLACK = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    
    //Font
    static let FONT_TYPE_BOLD:String = "Champagne&Limousines-Bold"
    static let FONT_TYPE:String = "Champagne&Limousines"
}