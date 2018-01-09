//
//  WorkOrderDetailTableViewCell.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 1/5/18.
//  Copyright © 2018 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class WorkOrderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var AddressValue: UILabel!
    
    @IBOutlet weak var LinearDistanceValue: UILabel!
    @IBOutlet weak var LinearDistance: UILabel!
    @IBOutlet weak var SendToUnit: Button!
    @IBAction func SendToUnit(_ sender: UIButton) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
