//
//  WorkDetailScreenTableViewController.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 1/8/18.
//  Copyright © 2018 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class WorkDetailScreenTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell1 = tableView.dequeueReusableCell(withIdentifier: "CellDetail1") as! WorkDetailTableViewCell
    
            var WorkOrderDetail = Base.sharedInstance.selectedWorkOrderDetail
            var Addressvalue1 = (Base.sharedInstance.selectedWorkOrderList?.addressLine1)! + (Base.sharedInstance.selectedWorkOrderList?.addressLine2)! +  (Base.sharedInstance.selectedWorkOrderList?.city)!
            cell1.AddressValue.text = Addressvalue1
            cell1.LinearDistanceValue.text = WorkOrderDetail?.sA_LinearDistanceApplication_act.description
            cell1.InjectionCountValue.text = WorkOrderDetail?.hT_InjectionCount_act.description
            cell1.HtModeValue.text = WorkOrderDetail?.hTModeEnabled.description
            cell1.SAModeValue.text = WorkOrderDetail?.sAModeEnabled.description
            cell1.chemicalUsedValue.text = Base.sharedInstance.selectedtermicideType?.termicideTypeName
            if((NSLocale.current.regionCode)! == "US"){
                cell1.chemicalHTValue.text = (WorkOrderDetail?.hT_TermicideVolume_act.description)!+"Ounces"
              cell1.chemicalSValue.text = (WorkOrderDetail?.sA_TermicideVolume_act.description)! + "Ounces"
                cell1.WaterSAModeValue.text = (WorkOrderDetail?.sA_WaterVolume_act.description)! + "Gallons"
            }else{
                
                cell1.chemicalHTValue.text = (Double((WorkOrderDetail?.hT_TermicideVolume_act)!)*0295735).description+"liters"
                cell1.chemicalSValue.text = (Double((WorkOrderDetail?.sA_TermicideVolume_act)!)*0295735).description + "liters"
                cell1.WaterSAModeValue.text = (Double((WorkOrderDetail?.sA_WaterVolume_act)!)*0295735).description + "liters"
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
        performSegue(withIdentifier: "WorkOrderDetail1", sender: self)
    }
}


