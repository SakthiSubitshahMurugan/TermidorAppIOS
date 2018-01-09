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

class WorkOrderList: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    struct ObjectKind {
        let type: String
        let belonging: [String]
    }
    var objects = [ObjectKind]()
    override func viewDidAppear(_ animated: Bool) {
        var new :ObjectKind?
        var onHold :ObjectKind?
        var completed:ObjectKind?
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        LoadWorkOrderList1(Url: "hjvhj", username: "b bn", password: "bn nb") { (true) in
            if(Base.sharedInstance.updatedWorkOrderIDs != Base.sharedInstance.WorkOrderID){
                self.objects.removeAll()
                LoadWorkOrderList2(Url: "hvh", username: "vn", password: "jv") { (t) in
                   new = ObjectKind(type: "New", belonging:Base.sharedInstance.newWorkOrder)
             
                   onHold = ObjectKind(type: "OnHold", belonging:Base.sharedInstance.onHoldWorkOrder )
               
                     completed = ObjectKind(type: "Completed", belonging:Base.sharedInstance.completeWorkOrder )
                 
                    if (Base.sharedInstance.newWorkOrder.isEmpty == false) {
                        self.objects.append(new!)
                       
                    }
                    if (Base.sharedInstance.onHoldWorkOrder.isEmpty == false) {
                        self.objects.append(onHold!)
                       
                    }
                    if (Base.sharedInstance.completeWorkOrder.isEmpty == false) {
                        self.objects.append(completed!)
                        
                    }
                  
                    self.do_table_refresh()
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
                }
            }
            else{
                LoadWorkOrderDetail1(Url: "hjvhj", username: "n nb", password: " nb "){(true)
                    in
                     MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
                    
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
      //  print("The numberOf section \(objects.count)")
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Base.sharedInstance.selectedWorkOrder = objects[indexPath.section].belonging[indexPath.row]
        print("-----Selected:\(Base.sharedInstance.selectedWorkOrder)")
                if let i = Base.sharedInstance.WorkOrderDetail.index(where: { $0.serviceWorkorderID == Base.sharedInstance.selectedWorkOrder }) {
                    Base.sharedInstance.selectedWorkOrderDetail = Base.sharedInstance.WorkOrderDetail[i]
                   print("Selected WorkOrderDetail----\(Base.sharedInstance.selectedWorkOrderDetail?.serviceWorkorderID)")
                }
                if let i = Base.sharedInstance.WorkOrderListObj.index(where: { $0.serviceWorkOrderId == Base.sharedInstance.selectedWorkOrder }) {
                    Base.sharedInstance.selectedWorkOrderList = Base.sharedInstance.WorkOrderListObj[i]
                    print("Selected WorkOrderList----\(Base.sharedInstance.selectedWorkOrderDetail?.serviceWorkorderID)")
                }
        let cell1 = tableView.cellForRow(at: indexPath as IndexPath)
        if(Base.sharedInstance.selectedWorkOrderDetail?.workorderStatusCode == "N"){
            performSegue(withIdentifier:"DetailSegue1", sender: cell1)
        }else{
            print("Hold and Complete")
          performSegue(withIdentifier:"DetailHoldAndComp", sender: cell1)
        }
        
       // let cell1 = tableView.cellForRow(at: indexPath as IndexPath)
       // performSegue(withIdentifier: "DetailSegue1", sender: cell1)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Base.sharedInstance.selectedWorkOrder?.removeAll()
        if segue.identifier == "DetailHoldAndComp"{
             print("Im here in Hold and Comp")
        let destinationVC = segue.destination as! WorkOrderDetailHoldAndCompTableViewController
        let indexpath = self.tableView.indexPath(for: sender as! UITableViewCell)!
        destinationVC.title = objects[indexpath.section].belonging[indexpath.row]
        }
    }
}
   
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        Base.sharedInstance.selectedWorkOrder?.removeAll()
//        let indexpath = self.tableView.indexPath(for: sender as! UITableViewCell)!
//         Base.sharedInstance.selectedWorkOrder = objects[indexpath.section].belonging[indexpath.row]
//        if let i = Base.sharedInstance.WorkOrderDetail.index(where: { $0.serviceWorkorderID == Base.sharedInstance.selectedWorkOrder }) {
//            Base.sharedInstance.selectedWorkOrderDetail = Base.sharedInstance.WorkOrderDetail[i]
//            //print("Selected WorkOrderDetail----\(Base.sharedInstance.selectedWorkOrderDetail)")
//        }
//        if let i = Base.sharedInstance.WorkOrderListObj.index(where: { $0.serviceWorkOrderId == Base.sharedInstance.selectedWorkOrder }) {
//            Base.sharedInstance.selectedWorkOrderList = Base.sharedInstance.WorkOrderListObj[i]
//        }
//        
//        if(Base.sharedInstance.selectedWorkOrderDetail?.workorderStatusCode == "N"){
//        if segue.identifier == "DetailSegue1" {
//            let destinationVC = segue.destination as! WorkOrderDetailHoldAndCompTableViewController
// //           let destinationVC = segue.destination as! WorkOrderDetailTableViewController
////            let indexpath = self.tableView.indexPath(for: sender as! UITableViewCell)!
////            Base.sharedInstance.selectedWorkOrder = objects[indexpath.section].belonging[indexpath.row]
////            if let i = Base.sharedInstance.WorkOrderDetail.index(where: { $0.serviceWorkorderID == Base.sharedInstance.selectedWorkOrder }) {
////                Base.sharedInstance.selectedWorkOrderDetail = Base.sharedInstance.WorkOrderDetail[i]
////            }
////            if let i = Base.sharedInstance.WorkOrderListObj.index(where: { $0.serviceWorkOrderId == Base.sharedInstance.selectedWorkOrder }) {
////                Base.sharedInstance.selectedWorkOrderList = Base.sharedInstance.WorkOrderListObj[i]
////            }
////
//            destinationVC.title = objects[indexpath.section].belonging[indexpath.row]
//           
//            }}else
//        {
//          if segue.identifier == "DetailHoldAndComp"{
//            print("Im here in Hold and Comp")
//             let destinationVC = segue.destination as! WorkOrderDetailHoldAndCompTableViewController
//            let indexpath = self.tableView.indexPath(for: sender as! UITableViewCell)!
//             destinationVC.title = objects[indexpath.section].belonging[indexpath.row]
//            }
//            
//        }
//    }
    
//}
//    }
//}



