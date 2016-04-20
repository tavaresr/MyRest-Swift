//
//  DataStore.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit
import CoreData

public class DataStore {
    class var current:DataStore{
        struct Singleton {
            static var instance: DataStore?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Singleton.token) {
            Singleton.instance = DataStore()
        }
        return Singleton.instance!
    }
    
    //Variables
    var ementa:NSArray?
    var noticia:NSArray?
    var pratosFavoritos = NSMutableArray() //Mutable Object - to add and remove objects
    
    //INIT
    init(){
        if let pratosFavoritos = NSUserDefaults.standardUserDefaults().objectForKey("PRATOS_FAVORITOS") as? NSMutableArray{
            self.pratosFavoritos = pratosFavoritos
        }
    }
    
    /*
    * Get data (Menu) from JSON file
    */
    func getEmenta(result:(NSArray)->()){
        EmentaManager.getEmenta{ (_ementa) -> () in
            self.ementa = _ementa
            result(_ementa)
        }
    }
    
    /*
    * Get data (News) from JSON file
    */
    func getNoticias(result:(NSArray)->()){
        NoticiasManager.getNoticias{ (_noticia) -> () in
            self.noticia = _noticia
            result(_noticia)
        }
    }
    
    /*
    * Get list of favorites
    */
    func getFavoritos(result:(NSArray)->()){
        result(self.pratosFavoritos)
    }
    
    /*
    * Check if already is favorite - NOT WORKING!! :(
    */
    func verificaFavorito(data:NSDictionary)->Bool{
        return self.pratosFavoritos.filteredArrayUsingPredicate((NSPredicate(format: "ementa.categoria.prato.id = %@", data.valueForKeyPath("ementa.categoria.prato.id")!.description))).count > 0
    }
    
    /*
    * Add to favorite
    */
    func adicionaFavorito(data:NSDictionary){
        if(!verificaFavorito(data)){
            let favorito = data.mutableCopy() as! NSMutableDictionary
            self.pratosFavoritos.addObject(favorito)
            
            NSNotificationCenter.defaultCenter().postNotificationName("PRATO_ADC", object: data)
            
            self.save()
            
            
            //CORE DATA
            if let pratoCoreData =  CoreDataManager.newObject("Pratos") as? Pratos {
                pratoCoreData.id = data.valueForKeyPath("ementa.categoria.prato.id")!.description
                pratoCoreData.nome = data.valueForKeyPath("ementa.categoria.prato.nome")!.description
                pratoCoreData.preco = data.valueForKeyPath("ementa.categoria.prato.preco")!.description
                pratoCoreData.categoria = (CoreDataManager.newObject("Categorias") as? Categorias!)!
                pratoCoreData.imagens = (CoreDataManager.newObject("Imagens") as? Imagens!)!
                pratoCoreData.imagens.nome = data.valueForKeyPath("ementa.categoria.prato.imagens.path")!.description;
                
                var error:NSError?
                do {
                    try CoreDataManager.current.managedObjectContext?.save()
                } catch let error1 as NSError {
                    error = error1
                }
                if(error != nil){
                    print(error?.localizedDescription)
                }
            }
        }
    }
    
    /*
    * Save data
    */
    func save(){
        NSUserDefaults.standardUserDefaults().setObject(self.pratosFavoritos, forKey: "PRATOS_FAVORITOS")
        
        NSNotificationCenter.defaultCenter().postNotificationName("SAVED!", object: ementa)
    }
    
}

