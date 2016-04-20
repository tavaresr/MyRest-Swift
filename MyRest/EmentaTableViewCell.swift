//
//  EmentaTableViewCell.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit


class EmentaTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var ementaTitle: UILabel!
    @IBOutlet weak var ementaImageView: UIImageView!
    @IBOutlet weak var ementaPreco: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}