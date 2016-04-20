//
//  EmentaTableViewController.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit

class EmentaTableViewController: UITableViewController {
    
    // Variables
    var ementa:NSArray?
    
    
    // Outlet Menu button
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    /*
    * ViewDidLoad method
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Menu settings
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            // Change the width of rear menu visible
            //self.revealViewController().rearViewRevealWidth = 62
        }
        
        // Load Ementa list
        //self.ementa = DataStore.current.pratos
        DataStore.current.getEmenta() { (result) -> () in
            self.ementa = result
            self.tableView?.reloadData()
        }
        
        // Refresh control settings
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("pullToRefresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        
    }
    
    /*
    * Method to refresh Ementa list when pull the screen
    */
    func pullToRefresh() {
        DataStore.current.getEmenta() { (result) -> () in
            self.ementa = result
            self.tableView?.reloadData()
        }
        refreshControl?.endRefreshing()
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
        
        // Configure the cell
        if let ementa = self.ementa?[indexPath.row] as? NSDictionary {
            
            let nome:String = ementa.valueForKeyPath("ementa.categoria.prato.nome") as! String
            let preco:String = ementa.valueForKeyPath("ementa.categoria.prato.preco") as! String
            
            cell.ementaTitle.text = nome
            cell.ementaPreco.text = "€ \(preco)"
            
            //load image
            if let path = ementa.valueForKeyPath("ementa.categoria.prato.imagens.path") as? NSString {
                var imgURL: NSURL = NSURL(string: path as String)!
                let request: NSURLRequest = NSURLRequest(URL: imgURL)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
                    completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
                        if error == nil {
                            cell.ementaImageView.image = UIImage(data: data!)
                        }
                })
            }else {
                cell.ementaImageView.image = nil
            }
        }
        return cell
    }
    
    
    /*
    *  Prepare data to send for detail
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.tableView?.indexPathForCell(sender as! UITableViewCell){
            let ementa = self.ementa?[indexPath.row] as? NSDictionary
            if let vc = segue.destinationViewController as? EmentaViewController{
                vc.ementa = ementa
            }
        }
    }
}
