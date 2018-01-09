//
//  WorkOrderDetailTableViewController.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 1/5/18.
//  Copyright © 2018 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class WorkOrderDetailTableViewController: UITableViewController {
    @IBOutlet weak var Status: UILabel!
      var BaseValue = Base.sharedInstance
    @IBOutlet weak var LinearDistance: UILabel!
    @IBOutlet weak var Address: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let next = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextTapped))
        navigationItem.rightBarButtonItems = [next]
        tableView.tableFooterView = UIView()
    tableView.backgroundColor = UIColor.lightGray
       // tableView.register(AnotherTableViewCell.self, forCellReuseIdentifier: "cell1")

//        tableView.estimatedRowHeight = 44
//        tableView.rowHeight = UITableViewAutomaticDimension
//
    }
    @objc func nextTapped(){
        performSegue(withIdentifier: "WorkOrderDetail1", sender: self)
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
          let cell1 = tableView.dequeueReusableCell(withIdentifier: "CellDetail") as! WorkOrderDetailTableViewCell
        cell1.Address.text = "Address"
        var Addressvalue1 = (BaseValue.selectedWorkOrderList?.addressLine1)! + (BaseValue.selectedWorkOrderList?.addressLine2)! +  (BaseValue.selectedWorkOrderList?.city)!
        print(Addressvalue1)
        cell1.AddressValue.text = Addressvalue1
        cell1.LinearDistance.text = "Linear Distance"
        cell1.LinearDistanceValue.text = BaseValue.selectedWorkOrderList?.linearDistancePlanned?.description
        if (Base.sharedInstance.selectedWorkOrderDetail?.workorderStatusCode == "C"||Base.sharedInstance.selectedWorkOrderDetail?.workorderStatusCode == "H"){
            cell1.SendToUnit.isHidden = true
            cell1.LinearDistanceValue.isHidden = true
            cell1.LinearDistance.isHidden = true
            LoadTermicideTypes(Url: "hvhj", username: "jbkj", password: "vj") { (true) in
                if let i = Base.sharedInstance.TermicidetypeObj.index(where: { $0.termicideTypeCode == Base.sharedInstance.selectedWorkOrderDetail?.termicideTypeCode_act }) {
                    Base.sharedInstance.selectedtermicideType = Base.sharedInstance.TermicidetypeObj[i]
                }
            }
         
        }
           return cell1
        }

   

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if (Base.sharedInstance.selectedWorkOrderDetail?.workorderStatusCode == "C"||Base.sharedInstance.selectedWorkOrderDetail?.workorderStatusCode == "H"){
            return 100
         }else {return 150}
       
}
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var returnValue:String?
        switch(BaseValue.selectedWorkOrderDetail?.workorderStatusCode)!{
        case "N"  :
                 returnValue="In Progress"
                break;
        case "O" :
                 returnValue="Open"
                break;
        case "H" :
                returnValue="Hold"
                break;
        case "C" :
               returnValue="Complete"
                break;
        default :print("None")
         
        }
        return returnValue
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "WorkOrderDetail1", sender: self)
    }
}
