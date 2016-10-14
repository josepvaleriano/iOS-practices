//
//  FugitivosTableViewController.swift
//  BrouryHunter
//
//  Created by Infraestructura on 08/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class FugitivosTableViewController: UITableViewController {

    var losFugados:NSArray?
    // para controlar todos los fugitivos ya sea captuarado o no se va a controlar la instanacia  haciendo una subclase de esta clase
    // se cambia el siguiente valor
     var estaCapturado = 0  // la cuañ no se hacer
    //Para hacer subclse se hace
    
    @IBAction func btnNuevoTouch(sender: AnyObject) {
        performSegueWithIdentifier("nuevo", sender: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        //super.viewDidAppear(animated)
        //self.cargarTabla()
    }
    
    override func viewWillAppear(animated: Bool) {
        //super.viewWillAppear(animated)
        self.cargarTabla()
    }
    
    func cargarTabla(){
        self.losFugados = DBManager.instance.encuentraTodosLosFiltrados("Fugitive", NSPredicate (format: "captured=%d",estaCapturado))
        
        print("\t tableviewControler principal capturado");
        // vuelve a ejecutar los metodos de ltodas las secciones , celdas y otros que se tengan implementados
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // iba por todos se cambiar por la filtraciòn  ver 1
        //self.losFugados = DBManager.instance.encuentraTodosLos( "Fugitive")
        // el predicate se pone como 0 para que no estan capturados ver 2
        /*
        self.losFugados = DBManager.instance.encuentraTodosLosFiltrados("Fugitive", NSPredicate (format: "captured=%d",estaCapturado))
   SE quite de viewdidaopaoer y solo se coloca en un solo lugar
        print("\t tableviewControler principal capturado");
 */
 //print(losFugados![1].valueForKey("name")!)
        // v se inicialzia los fugados para que cuando aparezca no marque error
        self.losFugados = NSArray()
        /*
         
        print("\timpresiòn de urlDeLaBD \(losFugados![1].valueForKey("name")!)!")
        print("\timpresiòn de urlDeLaBD \(losFugados[1].valueForKey("name")!")
        print("\timpresiòn de urlDeLaBD \(losFugados[1].valueForKey("name")!")
 */
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.losFugados!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseID", forIndexPath: indexPath)
        
        // Configure the cell...  cuadno n son objetos  ver 1
        //  cell.textLabel!.text = (self.losFugados![indexPath.row].valueForKey("name") as! String)
        //ahora que son hae el manejo de la base de datos como objetos se va a archivo base de datos editor create managersubclass
        //Se restrucctura la nueva forma de codificaciòn  ver 2

        let elFugitivo = self.losFugados![indexPath.row] as! Fugitive
        
        cell.textLabel!.text = elFugitivo.name! + " --> " + elFugitivo.desc!

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let elFugitivo = self.losFugados![indexPath.row] as! Fugitive
            do{
                //eliminamos el objeto del arreglo
                 DBManager.instance.managedObjetContext?.deleteObject(elFugitivo)
                //eliminamos el objeto de la base de datos
                try DBManager.instance.managedObjetContext?.save()
                self.cargarTabla()
            }catch{
                print("No se pudo eliminar el objeto del arreblo o problema en la base de datos")
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
