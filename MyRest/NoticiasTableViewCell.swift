//
//  NoticiasTableViewCell.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit


class NoticiasTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDesc: UITextView!
    @IBOutlet weak var newsImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
