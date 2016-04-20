//
//  FavoritosTableViewController.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit

class FavoritosTableViewController : UITableViewController{
   

    /*
     * ViewDidLoad method
     */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
    * Define number os sesctions
    */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    /*
    * Define number of rows
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if let ementa = self.ementa {
            return ementa.count
        }
        return 0
    }
    
    /*
    *  Load data to cell's
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EmentaTableViewCell
        
    
}
