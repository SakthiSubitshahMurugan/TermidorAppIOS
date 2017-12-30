//
//  WorkOrderTableViewCell.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/28/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class WorkOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var WorkOrderNum: UILabel!
    
    @IBOutlet weak var Address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
