//
//  GaleriaSecondViewController.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit

class GaleriaCollectionViewController : UICollectionViewController{
    
    //Variables
    var arr: [String] = []
    
    //Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    /*
    * ViewDidLoad method
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        arr=["galeria1.jpg","galeria2.jpg","galeria3.jpg","galeria4.jpg","galeria5.jpg","galeria6.jpg","galeria7.jpg","galeria8.jpg"]
        
        // Menu settings
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return arr.count
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell_img", forIndexPath: indexPath) as! GaleriaCollectionViewCell
        
        cell.imgCell.image = UIImage(named: arr[indexPath.row])
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell){
            let images = self.arr[indexPath.row]
            if let vc = segue.destinationViewController as? GaleriaSecondViewController{
                vc.images = images
            }
        }
    }
}
