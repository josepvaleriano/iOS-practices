//
//  DetalleEstado.swift
//  Practica1
//
//  Created by Infraestructura on 30/09/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class DetalleEstado: UIViewController {

    var info:NSDictionary?
    
    @IBOutlet weak var txtEntidad: UITextField!
    @IBOutlet weak var txtDetalle: UITextView!
    
    @IBOutlet weak var imgEstado: UIImageView!
    
    @IBAction func btnVerMAs(sender: AnyObject) {
        let sinEspacio = (self.info? ["entidad"] as! String).stringByReplacingOccurrencesOfString(" ", withString: "%20")
        let urlVerMar = "https://google.com/search?q=\(sinEspacio)"
        UIApplication.sharedApplication().openURL(NSURL(string:urlVerMar)!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        let infoCompleta = NSMutableString ()
        //let elPath = NSBundle.mainBundle().pathForResource("edo-mun", ofType: "plist")
        let pathImg = (self.info? ["entidad"] as! String).lowercaseString
        
        txtEntidad.text = self.info? ["entidad"] as! String
        //infoCompleta.appendString(self.info? ["entidad"] as! String + "\n")
        imgEstado.image = UIImage (named: pathImg)
        infoCompleta.appendString("Municipios : \n")
        
        let listaMunicipio = self.info?["municipios"] as! NSArray
        
        for nomMunicipio in listaMunicipio {
            // interpolaciòn de cadenas
            infoCompleta.appendString("* \(nomMunicipio as! String) \n")
        }
        
        self.txtDetalle!.text = infoCompleta as String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
