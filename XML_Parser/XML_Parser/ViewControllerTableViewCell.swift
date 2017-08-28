//
//  TableViewCell.swift
//  XML_Parser
//
//  Created by Abe Rodriguez on 1/30/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var season: UILabel!
    
    @IBOutlet weak var MyImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
