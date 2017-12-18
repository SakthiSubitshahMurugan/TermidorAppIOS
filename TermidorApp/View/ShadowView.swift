//
//  ShadowView.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/11/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import Foundation
import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        super.awakeFromNib()
    }
    
}
