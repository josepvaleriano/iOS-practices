//
//  DetailViewController.swift
//  PetCent
//
//  Created by Infraestructura on 14/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                let texto = "\(detail.valueForKey("nombre")!.description) \(detail.valueForKey("apellidos")!.description) \t" +
                    " fecha de nacimiento: \(detail.valueForKey("fechaNacimiento")!.description) " +
                    "\(detail.valueForKey("calleyno")!.description) "
                label.text = texto
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

