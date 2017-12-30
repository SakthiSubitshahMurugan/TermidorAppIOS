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
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        LoadWorkOrderList1(Url: "hvh", username: "vn", password: "jv") { (t) in
            // print("The onHoldWorkOrder \(Base.sharedInstance.onHoldWorkOrder)")
//            self.ObjectArray = [Objects(sectionName: "New", sectionObjects: ),
//                                Objects(sectionName: "Completed", sectionObjects: Base.sharedInstance.completeWorkOrder),
//                                Objects(sectionName: "onHold", sectionObjects: Base.sharedInstance.onHoldWorkOrder)]
            self.tableView.dataSource = self
            self.tableView.delegate = self
            
            let new = ObjectKind(type: "New", belonging:Base.sharedInstance.newWorkOrder)
            let onHold = ObjectKind(type: "OnHold", belonging:Base.sharedInstance.onHoldWorkOrder )
            let completed = ObjectKind(type: "Completed", belonging:Base.sharedInstance.completeWorkOrder )
            if(Base.sharedInstance.newWorkOrder.isEmpty == false){
            self.objects.append(new)
            }
            if(Base.sharedInstance.onHoldWorkOrder.isEmpty == false){
            self.objects.append(onHold)
            }
            if(Base.sharedInstance.onHoldWorkOrder.isEmpty == false){
            self.objects.append(completed)
            }
            self.do_table_refresh()
        }
        
           
           
        }
 
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//         return ObjectArray.count
//    }
//
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//       // print("numberOfRowsInSection\(ObjectArray[section])")
//         return ObjectArray[section].sectionObjects.count
//
//    }
//
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WorkOrderTableViewCell
//        print("The section is \(ObjectArray[indexPath.section])----\(ObjectArray[indexPath.section].sectionObjects[indexPath.row])")
//      //  print(ObjectArray[0])
//        print(indexPath.section)
//        cell.WorkOrderNum.text=ObjectArray[indexPath.section].sectionObjects[indexPath.row]
//        return cell
//
//    }
//
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//         return ObjectArray[section].sectionName
//    }
//
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
        print(WorkNum)
        print("Base Oject is \(Base.sharedInstance.WorkOrderIDandStaus)")
        let Address = Base.sharedInstance.WorkOrderIDandStaus.index{$0.workOrderNumber == WorkNum}
        print(Base.sharedInstance.WorkOrderIDandStaus[Address!].Address)
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
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
//    {
//
//    }
}


