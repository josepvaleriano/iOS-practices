//
//  DBManager.swift
//  PetCent
//
//  Created by Infraestructura on 14/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import Foundation
import CoreData

class DBManager{
    
    // se delcara el singleton
    static let instance = DBManager();
    
    // por lo tanto se quita static func encuentraTodosLos
    func todosLosRessponsables (nombreEntidad: String) -> NSArray {
        // es la llamada de un  qry
        let elQry:NSFetchRequest = NSFetchRequest()
        
        let laEntidad: NSEntityDescription =
            NSEntityDescription.entityForName(nombreEntidad,
                                              inManagedObjectContext: self.managedObjetContext!)!
        elQry.entity = laEntidad
        do{
            let result = try self.managedObjetContext!.executeFetchRequest(elQry)
            return result as NSArray
        }
        catch{
            print ("Error al ejecutar query")
            
            return NSArray()
        }
    }
    // ppara màs de un argumento el identificador del paràmetro se debe usar como etiqueta al
    //al invocar al mètodo
    func encuentraTodosLosOrdenados (nombreEntidad: String, _ ordenados: String) -> NSArray {
        
        return NSArray()
    }
    
    // ppara màs de un argumento el identificador del paràmetro se debe usar como etiqueta al
    //al invocar al mètodo
    func todosLosRessponsablesFiltrados (nombreEntidad: String, _ filtradosPor: NSPredicate) -> NSArray {
        // es la llamada de un  qry
        let elQry:NSFetchRequest = NSFetchRequest()
        
        let laEntidad: NSEntityDescription =
            NSEntityDescription.entityForName(nombreEntidad,
                                              inManagedObjectContext: self.managedObjetContext!)!
        elQry.entity = laEntidad
        elQry.predicate = filtradosPor
        do{
            let result = try self.managedObjetContext!.executeFetchRequest(elQry)
            return result as NSArray
        }
        catch{
            print ("Error al ejecutar query")
            
            return NSArray()
        }
        
        
        //return NSArray()
    }
    
    
    //Se realiza este 1ro
    lazy var managedObjetContext:NSManagedObjectContext? = {
        let persistence = self.persistentStore
        if persistence == nil {  //we have a problem
            return nil
        }
        //var moc = NSManagedObjectContext()
        var moc = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        moc.persistentStoreCoordinator = persistence
        return moc
        
    }()
    //Las
    
    // Se realiza la persistencia a la base
    lazy var persistentStore:NSPersistentStoreCoordinator? = {
        let model = self.managedObjectModel
        if model == nil{
            return nil
        }
        
        let persistence = NSPersistentStoreCoordinator(managedObjectModel:model! )
        //Encontrar la ubicaciòn de la base de datos
        let urlDeLaBD = self.directorioDocuments.URLByAppendingPathComponent("PetCens.sqlite")
        
        print("\timpresiòn de urlDeLaBD \(urlDeLaBD)")
        do{
            //configurar un direccionario
            let opcionesDePersistencia = [NSMigratePersistentStoresAutomaticallyOption:true,
                                          NSInferMappingModelAutomaticallyOption:true]
            try persistence.addPersistentStoreWithType (NSSQLiteStoreType,
                                                        configuration:nil, URL:urlDeLaBD,
                                                        options:opcionesDePersistencia)
        }
        catch{
            print("\t No se puede abrir la base de datos ubicada en  \(urlDeLaBD)")
            abort() // termina la ejecuciòn de la app
        }
        return persistence
    }()
    
    
    lazy var managedObjectModel:NSManagedObjectModel? = {
        // el archivo sqwl BountyHunter .xcdatamodelld tiene extensiòn momd sin que se vea es de solo lectura
        let modeURL = NSBundle.mainBundle().URLForResource("PetCens", withExtension: "momd")
        var model = NSManagedObjectModel(contentsOfURL: modeURL!)
        /* Los archivos que se agregan al proyecto en tiempo de diseño, queda ubicacod en
         "Resources" y son de solo lectura
         */
        
        return model
    }()
    
    lazy var directorioDocuments:NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(
            .DocumentDirectory, inDomains: .UserDomainMask)
        //return urls[0]  //implica cada usuario crear su diorectory
        return urls[urls.count - 1]
    }()
    
}
