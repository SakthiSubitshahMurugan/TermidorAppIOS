//
//  AnotherWorderDetailTableViewCell.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 1/8/18.
//  Copyright © 2018 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class AnotherWorderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var WorkOrderNum: UILabel!
    @IBOutlet weak var WorkOrderAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
