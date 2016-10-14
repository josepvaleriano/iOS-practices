//
//  ViewController.swift
//  NavigationExample
//
//  Created by Infraestructura on 23/09/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.label1.font = UIFont(name: "Jurassic Park", size:80.0)
        self.label1.text = NSLocalizedString("Titulo_pantalla_inicial", comment: "")
    }


}

