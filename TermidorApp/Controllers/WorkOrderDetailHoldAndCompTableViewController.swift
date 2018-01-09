//
//  WorkOrderDetailHoldAndCompTableViewController.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 1/8/18.
//  Copyright © 2018 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class WorkOrderDetailHoldAndCompTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let next = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextTapped))
        navigationItem.rightBarButtonItems = [next]
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! AnotherWorderDetailTableViewCell
        cell1.WorkOrderNum.text = Base.sharedInstance.selectedWorkOrderList?.serviceWorkOrderId
        var Addressvalue1 = (Base.sharedInstance.selectedWorkOrderList?.addressLine1)! + (Base.sharedInstance.selectedWorkOrderList?.addressLine2)! +  (Base.sharedInstance.selectedWorkOrderList?.city)!
        print(Addressvalue1)
        cell1.WorkOrderAddress.text = Addressvalue1
        LoadTermicideTypes(Url: "hvhj", username: "jbkj", password: "vj") { (true) in
            if let i = Base.sharedInstance.TermicidetypeObj.index(where: { $0.termicideTypeCode == Base.sharedInstance.selectedWorkOrderDetail?.termicideTypeCode_act }) {
                Base.sharedInstance.selectedtermicideType = Base.sharedInstance.TermicidetypeObj[i]
            }
        }
        
   
        return cell1
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var returnValue:String?
        switch(Base.sharedInstance.selectedWorkOrderDetail?.workorderStatusCode)!{
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
        performSegue(withIdentifier: "DetailSegue3", sender: self)
    }
}


