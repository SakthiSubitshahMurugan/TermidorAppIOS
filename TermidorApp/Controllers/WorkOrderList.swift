//
//  WorkOrderList.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/18/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//
//
//import UIKit
//import Alamofire
//import SwiftyJSON
//
//class WorkOrderList:UIViewController,UITableViewDelegate,UITableViewDataSource {
//
//    @IBOutlet weak var tableView: UITableView!
//    
//     @IBOutlet weak var menuButn: UIBarButtonItem!
//
//     var twoDimentionalArray = [[String]]()
// 
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        LoadWorkOrderList(Url: "v", username: "v", password: "feq")
//    
//        self.navigationItem.title = "WorkOrders"
//                menuButn.target = self.revealViewController()
//                menuButn.action = #selector(SWRevealViewController.revealToggle(_:))
//                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
//                self.revealViewController().rearViewRevealOverdraw = 240
//    
//        
//    }
//    
//
//
//
//}
//func LoadWorkOrderList(Url:String,username:String,password:String){
//    let inj = "http://stage.evergreen.datacore.us/WorkOrders"
//    let headers = [
//        "Authorization": "Bearer \(Base.sharedInstance.Token)",
//        "Content-Type": "application/X-Access-Token"
//    ]
//    Alamofire.request(inj, headers: headers).responseJSON { response in
//        //  print(response)
//        let json = JSON(response.result.value!)
//        if((json["Message"].string as String!) == "Authorization has been denied for this request."){
//            doAuth(username: "test_action3", password:"termite") { (true) in
//                LoadWorkOrderList(Url: "gjsbgjkb", username: username,password:password){(true) in
//                    //  completion(true)
//                }
//            }
//            
//        }else {
//            for (key, subJson) in json {
//                // print(key.count)
//                let ServMgmtPersonID = (subJson["ServMgmtPersonID"].string as String!)!
//                let ServMgmtUserRoleCode = (subJson["ServMgmtUserRoleCode"].string as String!)!
//                let ServMgmtUserSubRoleCode = (subJson["ServMgmtUserSubRoleCode"].string as String!)!
//                let ServMgmtGroupID = (subJson["ServMgmtGroupID"].string as String!)!
//                let ServiceWorkorderID = (subJson["ServiceWorkorderID"].string as String!)!
//                let ServiceWorkorderNumber = (subJson["ServiceWorkorderNumber"].intValue)
//                let ServMgmtWorkorderID = (subJson["ServMgmtWorkorderID"].string as String!)!
//                let CustomerGroupID = (subJson["CustomerGroupID"].string as String!)!
//                let CustomerPersonID = (subJson["CustomerPersonID"].string as String!)!
//                let CustomerUserRoleCode = (subJson["CustomerUserRoleCode"].string as String!)!
//                let CustomerUserSubRoleCode = (subJson["CustomerUserSubRoleCode"].string as String!)!
//                let CustomerFirstName = (subJson["CustomerFirstName"].string as String!)!
//                let CustomerLastName = (subJson["CustomerLastName"].string as String!)!
//                let LocationTitle = (subJson["LocationTitle"].string as String!)!
//                let LocationCode = (subJson["LocationCode"].string as String!)!
//                let AddressLine1 = (subJson["AddressLine1"].string as String!)!
//                let AddressLine2 = (subJson["AddressLine2"].string as String!)!
//                let AttentionLine = (subJson["AttentionLine"].string as String!)!
//                let PostalCode = (subJson["PostalCode"].string as String!)!
//                let StateProvinceCode = (subJson["StateProvinceCode"].string as String!)!
//                let City = (subJson["City"].string as String!)!
//                let CountryCode = (subJson["CountryCode"].string as String!)!
//                let WOGeneralNotes = (subJson["WOGeneralNotes"].string as String!)!
//                let WOLocationNotes = (subJson["WOLocationNotes"].string as String!)!
//                //  let GeneralNotes = (subJson["GeneralNotes"].string as String!)!
//                let WOAGeneralNotes = (subJson["WOAGeneralNotes"].string as String!)!
//                let Billable = (subJson["Billable"].string as String!)!
//                let TermicideTypeCode_pln = (subJson["TermicideTypeCode_pln"].string as String!)!
//                let SoilTypeCode_pln = (subJson["SoilTypeCode_pln"].string as String!)!
//                let SoilTypeRefCode_pln = (subJson["SoilTypeRefCode_pln"].intValue)
//                let HT_InjectionCount_pln = (subJson["HT_InjectionCount_pln"].intValue)
//                let HT_LinearDistanceApplication_pln = (subJson["HT_LinearDistanceApplication_pln"].intValue)
//                let HT_TermicideVolume_pln = (subJson["HT_TermicideVolume_pln"].intValue)
//                let HT_WaterVolume_pln = (subJson["HT_WaterVolume_pln"].floatValue)
//                let HT_PumpVolume_pln = (subJson["HT_PumpVolume_pln"].floatValue)
//                let HT_InjectorTimer_pln = (subJson["HT_InjectorTimer_pln"].floatValue)
//                let SA_InjectionCount_pln = (subJson["SA_InjectionCount_pln"].intValue)
//                let SA_LinearDistanceApplication_pln = (subJson["SA_LinearDistanceApplication_pln"].intValue)
//                let SA_TermicideVolume_pln = (subJson["SA_TermicideVolume_pln"].intValue)
//                let SA_WaterVolume_pln = (subJson["SA_WaterVolume_pln"].intValue)
//                let SA_PumpVolume_pln = (subJson["SA_PumpVolume_pln"].floatValue)
//                let SA_InjectorTimer_pln = (subJson["SA_InjectorTimer_pln"].floatValue)
//                let LinearMeasurementUnit_pln = (subJson["LinearMeasurementUnit_pln"].string as String!)!
//                let VolumeMeasurementUnit_pln = (subJson["VolumeMeasurementUnit_pln"].string as String!)!
//                let MinutesWorkedInSession_pln = (subJson["MinutesWorkedInSession_pln"].intValue)
//                let Demo = (subJson["Demo"].string as String!)!
//                let EntryTime = (subJson["EntryTime"].string as String!)!
//                let LastSyncTime = (subJson["LastSyncTime"].string as String!)!
//                let EntityActive = (subJson["EntityActive"].string as String!)!
//                let ViewportCode = (subJson["ViewportCode"].string as String!)!
//                let ReadyForArchive = (subJson["ReadyForArchive"].string as String!)!
//                let isNotTooOld = (subJson["isNotTooOld"].boolValue)
//                
//                print(ServiceWorkorderID)
//                Base.sharedInstance.WorkOrderID.append(ServiceWorkorderID)
//                LoadWorkOrderDetail(Url: "vh", username: "bv v", password: "cvb", completion: { (true) in
//                })
//            }
//        }
//    }
//}


    


