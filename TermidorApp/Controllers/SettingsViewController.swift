//
//  SettingsViewController.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/19/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import UIKit
import CoreBluetooth

class SettingsViewController: BaseOptionViewController{
    var peripherals:[CBPeripheral] = []
    var manager: CBCentralManager? = nil
    //var parentView:MainViewController? = nil

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationItem.title = "Settings"
        
    }
  
   
}
