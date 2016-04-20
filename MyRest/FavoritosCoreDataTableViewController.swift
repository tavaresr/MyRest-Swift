//
//  FavoritosCoreDataTableViewController.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit
import CoreData

class FavoritosCoreDataTableViewController : CoreDataTableViewController {
    
    var pratosFavoritos:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Request da Entidade
        let request = NSFetchRequest(entityName: "Pratos")
        
        //Ordenação é obrigatório
        request.sortDescriptors = [NSSortDescriptor(key: "nome", ascending: true)]
        
        if let context = CoreDataManager.current.managedObjectContext {
            self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "nome", cacheName: nil)
        }
    }
    
    /*
    * Load data to cell's
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        if let prato = self.fetchedResultsController.objectAtIndexPath(indexPath) as? Pratos {
            cell.textLabel!.text = prato.nome
            let preco_str = prato.preco
            let preco = preco_str!.stringByReplacingOccurrencesOfString("Optional", withString: "")
            cell.detailTextLabel!.text = "€ \(preco)"
        }
        
        return cell
    }
    
}