//
//  GaleriaViewController.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit


class GaleriaSecondViewController:UIViewController{
    
    @IBOutlet weak var imgFullView: UIImageView!
    
    var images: String!
    
    /*
    * ViewDidLoad method
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgFullView.image = UIImage(named: images)
    }
    
}