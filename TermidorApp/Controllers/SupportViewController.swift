//
//  SupportViewController.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/19/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class SupportViewController: BaseOptionViewController {

   
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationItem.title = "Support"
        // navigationController?.navigationBar.isTranslucent = false
     //   navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.003921568627, blue: 0.1098039216, alpha: 1)
       
        let textAttributes = [NSAttributedStringKey.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

   

}
