//
//  NuevoFugitivoVieCon.swift
//  BrouryHunter
//
//  Created by Infraestructura on 08/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit
import CoreData

class NuevoFugitivoVieCon: UIViewController {

    @IBOutlet weak var txtNombre: CustomTextField!
    
    @IBOutlet weak var txtDelito: CustomTextField!
    
    @IBOutlet weak var txtRecompensa: CustomTextField!
    
    @IBAction func btnGuardar(sender: AnyObject) {
        //validando campos
        var msg = ""
        if self.txtNombre.text == "" {
            msg = "Nombre required \t"
        }
        if self.txtDelito.text == "" {
            msg += "Delito required \t"
        }
        if self.txtRecompensa.text == "" {
            msg +=  "Recompensa required \t"
        }
            
        /*else{
            var num
            try{
                num = Int(self.txtRecompensa.text!)
            }catch{
                msg +=  " La Recompensa debe ser numerica \t \( num\)"
            }
        }
 */
        if msg != ""{
            let ac2 : UIAlertController = UIAlertController(title: "Alerta", message: msg, preferredStyle: .Alert)
            let bac2 = UIAlertAction(title: "OK", style: .Default, handler:nil)
            ac2.addAction(bac2)
            self.presentViewController(ac2, animated: true, completion: nil)
        }
        else{
            // creadno instancia
            let entityInfo = NSEntityDescription.entityForName("Fugitive", inManagedObjectContext: DBManager.instance.managedObjetContext!)
            let nuevoFugitivo = NSManagedObject.init(entity: entityInfo!, insertIntoManagedObjectContext: DBManager.instance.managedObjetContext!) as! Fugitive
            nuevoFugitivo.name = self.txtNombre.text
            // se convierte el number que es el unico que aplica
            nuevoFugitivo.bounty = NSDecimalNumber (string:self.txtRecompensa.text)
            nuevoFugitivo.desc = self.txtDelito.text
            nuevoFugitivo.captured = false
            do{
                try DBManager.instance.managedObjetContext!.save()
                // quita el view controler y regreso al anterior
                self.navigationController?.popViewControllerAnimated(true)
            } catch{
                print("Error al salvar la DB ... what's up?")
            }
            
            
        }
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
