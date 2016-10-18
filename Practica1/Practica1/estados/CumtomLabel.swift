//
//  CumtomLabel.swift
//  BrouryHunter
//
//  Created by Infraestructura on 01/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class CumtomLabel: UILabel {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        self.font = UIFont ( name: Constans.FONT_TYPE , size: Constans.FUENTE_SIZE_TITULOS)
        //self.backgroundColor = Constans.FUENTE_COLOR_TITULOS
        self.layer.backgroundColor = Constans.FUENTE_COLOR_ETIQUETAS.CGColor
        self.layer.cornerRadius = rect.size.height / 3
        self.textColor = Constans.FUENTE_COLOR_TEXTO
        super.drawRect(rect)
        
        DBManager.instance.encuentraTodosLosOrdenados("", "")
        
    }
    

}
