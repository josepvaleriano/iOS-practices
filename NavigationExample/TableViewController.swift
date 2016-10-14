//
//  TableViewController.swift
//  NavigationExample
//
//  Created by Infraestructura on 24/09/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var elArreglo: NSArray?
    var elArreglo2: NSArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.elArreglo = ["comida", "Bebida","lugar", "Otros"]
        
        self.elArreglo2 = [["Margarita", "BBQ Chicken", "Pepperoni","sausage", "meat lovers", "veggie lovers","sausage", "chicken pesto", "prawns", "mushrooms","Agua","Refresco"], ["Limonada","Cerveza","Tequila","Ron"], ["Cancun","Italia","Patagonia"], ["Privacidad"]]

        
        //self.elArreglo2 = ["Agua","Refresco","Limonada","Cerveza","Tequila","Ron"]
  //      self.elArreglo2 = ["Cancun","Italia","Patagonia"]
        
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Comida"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.elArreglo2!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.elArreglo2![section].count
        
        
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.elArreglo![section] as? String
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellForReuse", forIndexPath: indexPath)
        /*
        // 2 formas de buscar objeto por la version de xcode y ver del ios
        let item = self.elArreglo2! [indexPath.section] as! NSArray
        cell.textLabel!.text = (item [indexPath.row]as! String)
        */
        cell.textLabel!.text = (self.elArreglo2! [indexPath.section] [indexPath.row]as! String)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
