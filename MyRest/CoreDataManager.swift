//
//  CoreDataManager.swift
//  MyRest
//
//  Created by Ricardo Tavares (Miguel Duarte).
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager{
    private let modelName = "Model"
    //Singleton
    class var current:CoreDataManager{
        struct Singleton {
            static var instance: CoreDataManager?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Singleton.token) {
            Singleton.instance = CoreDataManager()
        }
        return Singleton.instance!
    }
    //Lazy loading - So instancia as variáveis quando são necessárias
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var applicationDocumentsDirectory: NSURL = {
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last as! NSURL!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("\(self.modelName).sqlite")
        
        
        
        var error: NSError? = nil
        do {
            try coordinator?.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            
            coordinator = nil
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            do {
                try NSFileManager.defaultManager().removeItemAtPath(url.absoluteString)
            } catch _ {
            }
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        if let coordinator = self.persistentStoreCoordinator {
            var managedObjectContext = NSManagedObjectContext()
            managedObjectContext.persistentStoreCoordinator = coordinator
            return managedObjectContext
        }else {
            return nil
        }
        }()
    
    class func newObject(entityName:String) -> NSManagedObject?{
        if (CoreDataManager.current.managedObjectContext != nil){
            var entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: CoreDataManager.current.managedObjectContext!)
            
            let newObject = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: CoreDataManager.current.managedObjectContext!) as? NSManagedObject
            return newObject
        }
        return nil
    }
    
    class func temporaryObject(entityName:String) ->NSManagedObject?{
        if (CoreDataManager.current.managedObjectContext != nil){
            if let description = NSEntityDescription.entityForName(entityName, inManagedObjectContext: CoreDataManager.current.managedObjectContext!) {
                let temporayObject = NSManagedObject(entity: description, insertIntoManagedObjectContext: nil)
                return temporayObject
            }
        }
        return nil
    }
}

