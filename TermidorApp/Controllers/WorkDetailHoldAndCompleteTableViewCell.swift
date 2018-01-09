//
//  WorkDetailHoldAndCompleteTableViewCell.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 1/8/18.
//  Copyright © 2018 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class WorkDetailHoldAndCompleteTableViewCell: UITableViewCell {
      @IBOutlet weak var SendToUnit: Button!
    @IBOutlet weak var LinearDistanceValue: UILabel!
    @IBOutlet weak var AddressValue: UITextView!
    @IBOutlet weak var SAModeValue: UILabel!
    @IBOutlet weak var HtModeValue: UILabel!
    @IBOutlet weak var WaterSAModeValue: UILabel!
    @IBOutlet weak var InjectionCountValue: UILabel!
    @IBOutlet weak var chemicalSValue: UILabel!
    @IBOutlet weak var chemicalHTValue: UILabel!
    @IBOutlet weak var chemicalUsedValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
