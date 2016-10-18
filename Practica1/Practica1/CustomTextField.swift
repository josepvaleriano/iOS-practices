//
//  CustomTextField.swift
//  BrouryHunter
//
//  Created by Infraestructura on 01/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func drawRect(rect: CGRect) {
        
        
        self.textColor = UIColor.brownColor()
        self.backgroundColor = Constans.FUENTE_COLOR_SUB
        // REDONDEAR LA 3 o 4 parte
        self.layer.cornerRadius = rect.size.height / 3
        self.font = UIFont (name: Constans.FONT_TYPE_BOLD, size: Constans.FUENTE_SIZE_NORMAL)
        //FUENTE DEL PLACEHOLDER "CH&-BOLD" 18 PX"
        let atributos = [NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                         NSFontAttributeName: UIFont(name:Constans.FONT_TYPE , size: Constans.FUENTE_SIZE_NORMAL)!]
        var placeHolderOriginal = self.placeholder
        if placeHolderOriginal == nil{
            placeHolderOriginal = ""
        }
        
        self.attributedPlaceholder = NSAttributedString (string: placeHolderOriginal!, attributes: atributos)
        super.drawRect(rect)
       
                
    }
}
