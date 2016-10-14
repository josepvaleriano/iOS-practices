//
//  ViewController.swift
//  Practica1
//
//  Created by Infraestructura on 30/09/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBAction func btnEntrar(sender: AnyObject) {
        if self.txtEmail.text != "" {
           if self.txtPassword.text != "" {
                performSegueWithIdentifier("login", sender: self)
            }
           else{
            let ac : UIAlertController = UIAlertController(title: "Error", message: "Passwd required", preferredStyle: .Alert)
            let bac = UIAlertAction(title: "OK", style: .Default, handler:nil)
            ac.addAction(bac)
            self.presentViewController(ac, animated: true, completion: nil)
            }
        }
        else{
            let ac2 : UIAlertController = UIAlertController(title: "Error", message: "Email required", preferredStyle: .Alert)
            let bac2 = UIAlertAction(title: "OK", style: .Default, handler:nil)
            ac2.addAction(bac2)
            self.presentViewController(ac2, animated: true, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

