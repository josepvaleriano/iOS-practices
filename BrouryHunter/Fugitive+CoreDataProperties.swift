//
//  Fugitive+CoreDataProperties.swift
//  BrouryHunter
//
//  Created by Infraestructura on 08/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Fugitive {

    @NSManaged var bounty: NSDecimalNumber?
    @NSManaged var captDate: NSTimeInterval
    @NSManaged var captured: Bool
    @NSManaged var capturedLat: Double
    @NSManaged var capturedLon: Double
    @NSManaged var desc: String?
    @NSManaged var fugitiveId: Int16
    @NSManaged var image: NSData?
    @NSManaged var name: String?
    //herencia entr categorizaciòn y extenciòn 
    //categorzzaciòn se hereden los metodo de la clase padre
    //la ext toma la clase padre y sobre escribe metdos
    //@NSManaged hace la variable manejable pero lo hace retrazable para su uso

}
