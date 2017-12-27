//
//  WorkOrderList.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/18/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import UIKit

class WorkOrderList:UITableViewController {

    
     @IBOutlet weak var menuButn: UIBarButtonItem!
    var newWorkOrder = [WorkOrderBriefData]()
    var openWorkOder = [WorkOrderBriefData]()
    var onHoldWorkOrder = [WorkOrderBriefData]()
    var assingedWorkOrder = [WorkOrderBriefData]()
    var completeWorkOrder = [WorkOrderBriefData]()

    struct Objects {
        var sectionName:String!
        var sectionObjects : [WorkOrderBriefData]!
    }
    var ObjectArray = [Objects]()
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadWorkOrderList(Url: "jbjkb", username: "jbjkb", password: "hvhj") { (true) in
            if(Base.sharedInstance.WorkOrderBriefObj.count != nil){
                for i in Base.sharedInstance.WorkOrderBriefObj{
                    if(i.status == "H"){
                        self.onHoldWorkOrder.append(i)
                    }
                    
                    if(i.status == "O"){
                        self.openWorkOder.append(i)
                    }
                    if(i.status == "C"){
                        self.completeWorkOrder.append(i)
                    }
                    if(i.status == "N"){
                        self.newWorkOrder.append(i)
                    }
                }
            
    
        }
            
        }
        self.navigationItem.title = "WorkOrders"
                menuButn.target = self.revealViewController()
                menuButn.action = #selector(SWRevealViewController.revealToggle(_:))
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
                self.revealViewController().rearViewRevealOverdraw = 240
        
        
        ObjectArray = [Objects(sectionName: "New", sectionObjects: newWorkOrder),
                       Objects(sectionName: "Open", sectionObjects: openWorkOder),
                       Objects(sectionName: "On Hold", sectionObjects: onHoldWorkOrder),
                       Objects(sectionName: "Assinged", sectionObjects: assingedWorkOrder),
                       Objects(sectionName: "Complete", sectionObjects: completeWorkOrder)
        ]
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ObjectArray[section].sectionObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell!
        cell?.textLabel?.text = ObjectArray[indexPath.section].sectionObjects.[indexPath.row]
        return cell!
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ObjectArray.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ObjectArray[section].sectionName
    }
    
    
    
}

