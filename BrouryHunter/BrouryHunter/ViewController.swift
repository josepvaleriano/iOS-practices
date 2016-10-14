//
//  ViewController.swift
//  BrouryHunter
//
//  Created by Infraestructura on 01/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for fontFamilyName in UIFont.familyNames(){
            print (fontFamilyName)
            for fontName in UIFont.fontNamesForFamilyName(fontFamilyName){
                print("\t\(fontName)")
            }
            // sacar log del dispositivo sin embargo no debe enviar nada a la consola en producciòn
            
        }
        print("\t termina el viewControler principal");
        //Llamando a lafunciòn
        /*
       let losFugitivos = DBManager.instance.encuentraTodosLos( "Fugitive")
         print("\timpresiòn de urlDeLaBD \(losFugitivos[0])")
         print("\timpresiòn de urlDeLaBD \(losFugitivos[0])")
         print("\timpresiòn de urlDeLaBD \(losFugitivos[0])")
        for item in losFugitivos {
   se cambia a table view controler esta seccion del codigo        
        }
 */
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

