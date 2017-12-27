//
//  BaseViewController.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/20/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class BaseOptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "smackBurger-1"), style:.plain, target: self.revealViewController(), action:#selector(SWRevealViewController.revealToggle(_:)))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.revealViewController().rearViewRevealOverdraw = 240
    }

  


}
