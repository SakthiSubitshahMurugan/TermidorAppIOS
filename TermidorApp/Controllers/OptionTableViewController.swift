//
//  OptionTableViewController.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/19/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class OptionTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row{
        case 0:shouldPerformSegue(withIdentifier: "SupportViewController", sender: self)
                break
        case 1:shouldPerformSegue(withIdentifier: "SettingsViewController", sender: self)
                break;
        case 2:shouldPerformSegue(withIdentifier: "TrainingViewController", sender: self)
                break;
        case 3:shouldPerformSegue(withIdentifier: "WorkOrderList", sender: self)
                break;
        default:
         print("obrveb")
        }
    }

}
