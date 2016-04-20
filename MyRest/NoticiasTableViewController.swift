//
//  NoticiasTableViewController.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit

class NoticiasTableViewController:UITableViewController{
    
    // Variables
    var noticias:NSArray?
    
    
    //Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
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
        }
        
        // Load Ementa list
        //self.ementa = DataStore.current.pratos
        DataStore.current.getNoticias() { (result) -> () in
            self.noticias = result
            self.tableView?.reloadData()
        }
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
        if let noticias = self.noticias {
            return noticias.count
        }
        return 0
    }
    
    
    /*
    *  Load data to cell's
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellNews", forIndexPath: indexPath) as! NoticiasTableViewCell
        
        // Configure the cell
        if let noticia = self.noticias?[indexPath.row] as? NSDictionary {
            
            let titulo:String = noticia.valueForKeyPath("noticia.titulo") as! String
            let descricao:String = noticia.valueForKeyPath("noticia.descricao") as! String
            
            cell.newsTitle.text = titulo
            cell.newsDesc.text = descricao
            
            //load image
            if let path = noticia.valueForKeyPath("noticia.imagens.path") as? NSString {
                var imgURL: NSURL = NSURL(string: path as String)!
                let request: NSURLRequest = NSURLRequest(URL: imgURL)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(),
                    completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
                        if error == nil {
                            cell.newsImageView.image = UIImage(data: data!)
                        }
                })
            }else {
                cell.newsImageView.image = nil
            }
        }
        return cell
    }
    
}