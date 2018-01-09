//
//  WorkOrderDetailViewController.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 1/2/18.
//  Copyright © 2018 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class WorkOrderDetailViewController: UIViewController {
    var Addressvalue:String?
    var LinearDistance:String?
    var BaseValue = Base.sharedInstance
    @IBOutlet weak var SendUnitOutlet: Button!
    @IBAction func SendUnit(_ sender: Any) {
        if Base.sharedInstance.selectedWorkOrderDetail?.workorderStatusCode == "N"{
            (sender as! UIButton).isHidden = true
        }
        
        
    }
    @IBOutlet weak var linear_Distance: UILabel!
    @IBOutlet weak var Address: UILabel!
    override func viewDidLoad() {
        let next = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextTapped))
        navigationItem.rightBarButtonItems = [next]
        super.viewDidLoad()
    }
    @objc func nextTapped(){
        performSegue(withIdentifier: "WorkOrderDetail1", sender: self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
            if (Base.sharedInstance.selectedWorkOrderDetail?.workorderStatusCode == "C"||Base.sharedInstance.selectedWorkOrderDetail?.workorderStatusCode == "H"){
            SendUnitOutlet.isHidden = true
            }
        
        print(Addressvalue!)
}

}
