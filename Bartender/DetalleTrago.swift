//
//  DetalleTrago.swift
//  Bartender
//
//  Created by Infraestructura on 12/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class DetalleTrago: UIViewController {

    
    var info:NSDictionary?
    
    @IBOutlet weak var imgDrink: UIImageView!
    //@IBOutlet weak var imgDrink: UIImageView!
   // @IBOutlet weak var txtBebida: UILabel!
    
    @IBOutlet weak var txtBebida: UILabel!
    //@IBOutlet weak var imgDrk: UIImageView!
    //@IBOutlet weak var txtIngredientes: UILabel!
    
    @IBOutlet weak var txtIngredientes: UILabel!
    //@IBOutlet weak var txtDirection: UILabel!
    
    @IBOutlet weak var txtDirection: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        let ingre = self.info?["ingredients"] as! String
        let dire = self.info?["directions"] as! String
        txtBebida.text = self.info?["name"] as! String
        imgDrink.image = UIImage(named: self.info?["image"] as! String)
        txtIngredientes.text = ingre
        txtDirection.text =  dire
        
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
