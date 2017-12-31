//
//  NewViewController.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/28/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class NewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    struct ObjectKind {
        let type: String
        let belonging: [String]
    }
//    struct Objects {
//        var sectionName:String!
//        var sectionObjects : [String]!
//    }
       var objects = [ObjectKind]()
   // var ObjectArray = [Objects]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        LoadWorkOrderList1(Url: "hjvhj", username: "b bn", password: "bn nb") { (true) in
            print("-----------updatedWorkOderID-------------")
            if(Base.sharedInstance.updatedWorkOrderIDs != Base.sharedInstance.WorkOrderID){
                print("-------updatedWorkOderIDnoteqaul---------")
                LoadWorkOrderList2(Url: "hvh", username: "vn", password: "jv") { (t) in
                    print("-----Finding the new workorder list----------")
                    let new = ObjectKind(type: "New", belonging:Base.sharedInstance.newWorkOrder)
                    let onHold = ObjectKind(type: "OnHold", belonging:Base.sharedInstance.onHoldWorkOrder )
                    let completed = ObjectKind(type: "Completed", belonging:Base.sharedInstance.completeWorkOrder )
                    
                    if (!Base.sharedInstance.newWorkOrder.isEmpty) {
                        self.objects.append(new)
                    }
                    if (!Base.sharedInstance.onHoldWorkOrder.isEmpty) {
                        self.objects.append(onHold)
                    }
                    if (!Base.sharedInstance.onHoldWorkOrder.isEmpty) {
                        self.objects.append(completed)
                    }
                    self.do_table_refresh()
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
                }
                
            }
            else{
                LoadWorkOrderDetail1(Url: "hjvhj", username: "n nb", password: " nb "){(true)
                    in
                    print("----Updated Work Order Detail--------")

            }
        }
        
    
           
        }
    }

    func do_table_refresh()
    {
            self.tableView.reloadData()
            return
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return objects.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects[section].belonging.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WorkOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WorkOrderTableViewCell
        let WorkNum = objects[indexPath.section].belonging[indexPath.row]
        cell.WorkOrderNum.text = WorkNum
        let Address = Base.sharedInstance.WorkOrderIDandStaus.index{$0.workOrderNumber == WorkNum}
        cell.Address.text = Base.sharedInstance.WorkOrderIDandStaus[Address!].Address as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objects[section].type
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100.0
    }

}


