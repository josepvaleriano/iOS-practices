//
//  CapturadosTabVieCon.swift
//  BrouryHunter
//
//  Created by Infraestructura on 08/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class CapturadosTabVieCon: FugitivosTableViewController {

    override func viewDidLoad() {
        self.estaCapturado = 1
        super.viewDidLoad()
        print("\ttableviewControler caprutados");
        

        // Do any additional setup after loading the view.
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
