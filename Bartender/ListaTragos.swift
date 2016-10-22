//
//  ListadoTragos.swift
//  Bartender
//
//  Created by Soporte-iMAC on 11/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit

class ListadoTragos: UITableViewController {
    var losDrinks:NSArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Buscar el path del archivo dentro de los recursos del app
        let elPath = NSBundle.mainBundle().pathForResource("Drinks", ofType: "plist")
        self.losDrinks = NSArray(contentsOfFile:elPath!)
        self.navigationItem.title = "Tragos"
        
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
        return self.losDrinks!.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        // Configure the cell...
        let doctInfo = self.losDrinks![indexPath.row] as! NSDictionary
        cell.textLabel?.text = (doctInfo["name"] as! String)
        let laImagen = (doctInfo["image"] as! String).lowercaseString
        cell.imageView?.image = UIImage(named: laImagen)
        cell.indentationWidth = 10.0
        
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont (name:"Arial Rounded MT Bold", size:15.0)
        cell.textLabel?.numberOfLines=2;
        // cell.textLabel?.lineBreakMode =  UILineBreakModeMiddleTruncation;
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destino = segue.destinationViewController as! DetalleTrago
        // Pass the selected object to the new view controller.
        let elIndexPath = self.tableView.indexPathForSelectedRow
        let dictInfo = self.losDrinks![elIndexPath!.row] as! NSDictionary
        destino.info = dictInfo
 
    }
 
    
    
    
}
