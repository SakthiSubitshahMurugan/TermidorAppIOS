//
//  BASF_Service.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/6/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SystemConfiguration
import SwiftKeychainWrapper
import Toast_Swift

func doAuth(username: String, password: String,completion:@escaping ( _ success:Bool)->Void){
    var token:String = ""
    let params = ["username": username, "password": password, "grant_type" : "password"] as [String : Any]
    Alamofire.request(Url,method: .post, parameters: params).validate().responseJSON{response in
        let statusCode = response.response!.statusCode
        switch statusCode {
        case 200...299:
            let jsonData = JSON(response.result.value!)
            token = jsonData["access_token"].string as String!
            Base.sharedInstance.Token = token
            _ = KeychainWrapper.standard.set(token, forKey: "token")
           Base.sharedInstance.Token = KeychainWrapper.standard.string(forKey: "token")!
             completion(true)
        case 400...499:
             Base.sharedInstance.result="Invalid Username or Password"
            completion(true)
        default: break
        }
    }
}
public func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            SCNetworkReachabilityCreateWithAddress(nil, $0)
        }
    }) else {
        return false
    }
    
    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    
    return (isReachable && !needsConnection)
}
 

func UserAuth(token:String,UserLoginUrl:String,password:String,username:String,completion:@escaping ( _ success:Bool)->Void){

    let actualUrl = "http://stage.evergreen.datacore.us/Person?UserLoginName="+username
    print(actualUrl)
    let headers = [
        "Authorization": "Bearer \(token)",
        "Content-Type": "application/X-Access-Token"
    ]
    Alamofire.request(actualUrl, headers: headers).responseJSON { response in
        let json = JSON(response.result.value!)
        if ((response.response?.statusCode) != nil){
        let statusCode = response.response!.statusCode
        if (statusCode>=500){
             Base.sharedInstance.ServiceAvailabilty = "N"
            completion(true)
            return
        }else if(!(json["PersonID"].exists()) && (!(json["Message"].exists()))){
             Base.sharedInstance.result="Invalid Username or Password"
            completion(true)
            return
        }else{
              let json = JSON(response.result.value!)
        if((json["Message"].string as String!) == "Authorization has been denied for this request."){
            doAuth(username: username, password: password) { (true) in
                if(Base.sharedInstance.result != "Invalid Username or Password"){
                UserAuth(token: Base.sharedInstance.Token, UserLoginUrl: actualUrl, password: password, username: username, completion: { (true) in
                 completion(true)
                })
                }else{
                    completion(true)
                    return
                }
            }
        }else{
            Base.sharedInstance.Global = User.init(Username: username, Password: password, PersonID: json["PersonID"].string as String!, UserRoleCode: json["UserRoleCode"].string as String!, UserSubRoleCode:json["UserSubRoleCode"].string as String!, GroupID:json["GroupID"].string as String!, GroupName:json["GroupName"].string as String!, FirstName:  json["FirstName"].string as String!, LastName: json["LastName"].string as String!
, RememberMe:"N", CanDoTraining: json["CanCompleteTrainingSWO"].string as String!, RemoteValidationRequired: json["RemoteValidationRequired"].string as String!, IsOnline: "Y", MobileAppVersion:json["CanCompleteTrainingSWO"].string as String!)
            completion(true)
            
        }
    }
    }else{
        completion(true)
        Base.sharedInstance.result="Invalid Username or Password"
        return
    }

}
}

func LoadInjectionStation (Url:String,username:String,password:String,completion:@escaping ( _ success:Bool)->Void){
    let inj = "http://stage.evergreen.datacore.us/InjectionStations"
    let headers = [
        "Authorization": "Bearer \(Base.sharedInstance.Token)",
        "Content-Type": "application/X-Access-Token"
    ]
    Alamofire.request(inj, headers: headers).responseJSON { response in
        let json = JSON(response.result.value!)
        if((json["Message"].string as String!) == "Authorization has been denied for this request."){
            doAuth(username: "termite", password:"test_action3") { (true) in
                LoadInjectionStation(Url: "gjsbgjkb", username: username,password:password){(true) in
                //completion(true)
                }
                }
                
        }else {
            for (_, subJson) in json {
                    let InjectionStationID = (subJson["InjectionStationID"].string as String!)!
                    let InjectionStationName = (subJson["InjectionStationName"].string as String!)!
                    let IPAddress = (subJson["IPAddress"].string as String!)!
                    let ControllerIPAddress = (subJson["ControllerIPAddress"].string as String!)!
                Base.sharedInstance.InjectionStationObj.append(InjectionStationData.init(InjectionStationID: InjectionStationID, InjectionStationName: InjectionStationName, ControllerIPAddress: ControllerIPAddress, IPAddress: IPAddress))
                }
             completion(true)
            }
        completion(true)
        }
    completion(true)
    }
    
func LoadTermicideTypes (Url:String,username:String,password:String,completion:@escaping ( _ success:Bool)->Void){
    Base.sharedInstance.TermicidetypeObj.removeAll()
    let inj = "http://stage.evergreen.datacore.us/TermicideTypes"
    let headers = [
        "Authorization": "Bearer \(Base.sharedInstance.Token)",
        "Content-Type": "application/X-Access-Token"
    ]
    Alamofire.request(inj, headers: headers).responseJSON { response in
            let json = JSON(response.result.value!)
       if((json["Message"].string as String!) == "Authorization has been denied for this request."){
            doAuth(username: "termite", password:"test_action3") { (true) in
                LoadInjectionStation(Url: "gjsbgjkb", username: username,password:password){(true) in
                    completion(true)
                }
            }
            
        }else {
        for (_, subJson) in json {
                let DilutionRatio = (subJson["DilutionRatio"].intValue)
                let InjectionCountFactor = (subJson["InjectionCountFactor"].floatValue)
                let TermicideTypeCode = (subJson["TermicideTypeCode"].string as String!)!
                let TermicideTypeName = (subJson["TermicideTypeName"].string as String!)!
                let termi = TermicideTypeData.init(TermicideTypeCode: TermicideTypeCode, TermicideTypeName: TermicideTypeName, DilutionRatio: DilutionRatio.description, InjectionCountFactor: InjectionCountFactor.description)
                Base.sharedInstance.TermicidetypeObj.append(termi)
            }
         completion(true)
        }
completion(true)
}
    completion(true)
}

func LoadWorkOrderList1(Url:String,username:String,password:String,completions: @escaping ( _ success:Bool)->Void){
    Base.sharedInstance.updatedWorkOrderIDs.removeAll()
    var resCount = 1
    var tempCount = 0
    var DetailCount=0
    let inj = "http://stage.evergreen.datacore.us/WorkOrders"
    let headers = [
        "Authorization": "Bearer \(Base.sharedInstance.Token)",
        "Content-Type": "application/X-Access-Token"
    ]
    Alamofire.request(inj, headers: headers).responseJSON { response in
        
        //  print(response)
        let json = JSON(response.result.value!)
        
        if((json["Message"].string as String!) != "Authorization has been denied for this request.")  {
            resCount=json.count
        }
        
        if((json["Message"].string as String!) == "Authorization has been denied for this request."){
            doAuth(username: "test_action3", password:"termite") { (true) in
                LoadWorkOrderList1(Url: "gjsbgjkb", username: username,password:password){(true) in
                    completions(false)
                }
            }
            
        }else {
            
            for (key, subJson) in json {
                tempCount = tempCount+1
            //    print(tempCount)

                let ServiceWorkorderID = (subJson["ServiceWorkorderID"].string as String!)!
          //      print(ServiceWorkorderID)
               // Base.sharedInstance.WorkOrderID.append(ServiceWorkorderID)
                
                Base.sharedInstance.updatedWorkOrderIDs.append(ServiceWorkorderID)
               // print(Base.sharedInstance.updatedWorkOrderIDs)
//                let AddressLine1 = (subJson["AddressLine1"].string as String!)!
//                let AddressLine2 = (subJson["AddressLine2"].string as String!)!
//                let AttentionLine = (subJson["AttentionLine"].string as String!)!
//                let PostalCode = (subJson["PostalCode"].string as String!)!
//                let StateProvinceCode = (subJson["StateProvinceCode"].string as String!)!
//                let City = (subJson["City"].string as String!)!
//                Base.sharedInstance.WorkOrderIDandStaus.append(workOrderIdandstatusData.init(WorkOrderNumber: ServiceWorkorderID, Address: "\(AddressLine1)\(City)\(StateProvinceCode)"))
//
//                LoadWorkOrderDetail1(Url: "vh", username: "bv v", password: "cvb", completion: { (true) in
//                    DetailCount=DetailCount+1
//                    if(resCount == DetailCount ){
////                        print("resCount is \(resCount)")
////                        print("tempCount is \(DetailCount)")
////                        print("Wcompleted")
//                    } else {
////                        print("resCount is \(resCount)")
////                        print("tempCount is \(DetailCount)")
////                        print("Not Wcompleted")
//
//
//                    }
//
//                })
//
                if(resCount==tempCount){
                    //  print("Final  Wcompleted")
                    completions(true)
                }
            }
            
        }
        
        
    }
    
    
}

func LoadWorkOrderDetail1(Url:String,username:String,password:String,completion:@escaping ( _ success:Bool)->Void){

   Base.sharedInstance.WorkOrderDetail.removeAll()
  
for i in Base.sharedInstance.WorkOrderID{
    let headers = [
        "Authorization": "Bearer \(Base.sharedInstance.Token)",
        "Content-Type": "application/X-Access-Token"
    ]
    let params = ["WO_Number": i, "SyncTime": Base.sharedInstance.SyncTime] as [String : Any]
    var detailwithsynctime = "http://stage.evergreen.datacore.us/WorkOrderDetailAfterTime"
    Alamofire.request(detailwithsynctime,method: .get, parameters: params,headers:headers).validate().responseJSON{response in
       
         //  Alamofire.request(detailwithsynctime, headers: headers).responseJSON { response in
       // print(response)
        let json = JSON(response.result.value!)
        if((json["Message"].string as String!) == "Authorization has been denied for this request."){
            doAuth(username: "test_action3", password:"termite") { (true) in
                LoadWorkOrderDetail1(Url: "gjsbgjkb", username: username,password:password){(true) in
                }
            }

        }else {
            let WorkorderStatusCode = (json["WorkorderStatusCode"].stringValue)
            let EntrySeq=(json["EntrySeq"].intValue)
            let EntryTime=(json["EntryTime"].stringValue)
            let EntityActive=(json["EntityActive"].stringValue)
            let ViewportCode=(json["ViewportCode"].stringValue)
            let ServiceWorkorderID=(json["ServiceWorkorderID"].stringValue)
            let ServiceWorkorderNumber=(json["ServiceWorkorderNumber"].intValue)
            let LatestEntry=(json["LatestEntry"].stringValue)
            let ServMgmtGroupID=(json["ServMgmtGroupID"].stringValue)
            let ServMgmtPersonID=(json["ServMgmtPersonID"].stringValue)
            let ServMgmtUserRoleCode=(json["ServMgmtUserRoleCode"].stringValue)
            let ServMgmtUserSubRoleCode=(json["ServMgmtUserSubRoleCode"].stringValue)
            let InjectionStationID_act=(json["InjectionStationID_act"].stringValue)
            let TermicideTypeCode_act=(json["TermicideTypeCode_act"].stringValue)
            let SoilTypeCode_act=(json["SoilTypeCode_act"].stringValue)
            let SoilTypeRefCode_act=(json["SoilTypeRefCode_act"].intValue)
            let HT_InjectionCount_act=(json["HT_InjectionCount_act"].intValue)
            let HT_LinearDistanceApplication_act=(json["HT_LinearDistanceApplication_act"].intValue)
            let HT_TermicideVolume_act=(json["HT_TermicideVolume_act"].intValue)
            let HT_WaterVolume_act=(json["HT_WaterVolume_act"].intValue)
            let HT_PumpVolume_act=(json["HT_PumpVolume_act"].doubleValue)
            let HT_InjectorTimer_act=(json["HT_InjectorTimer_act"].intValue)
            let SA_InjectionCount_act=(json["SA_InjectionCount_act"].intValue)
            let SA_LinearDistanceApplication_act=(json["SA_LinearDistanceApplication_act"].intValue)
            let SA_TermicideVolume_act=(json["SA_TermicideVolume_act"].intValue)
            let SA_WaterVolume_act=(json["SA_WaterVolume_act"].intValue)
            let SA_PumpVolume_act=(json["SA_PumpVolume_act"].doubleValue)
            let SA_InjectorTimer_act=(json["SA_InjectorTimer_act"].intValue)
            let FlowRate=(json["FlowRate"].intValue)
            let DosingVolume=(json["DosingVolume"].intValue)
            let LinearMeasurementUnit_act=(json["LinearMeasurementUnit_act"].stringValue)
            let VolumeMeasurementUnit_act=(json["VolumeMeasurementUnit_act"].stringValue)
            let Latitude=(json["Latitude"].intValue)
            let Longitude=(json["Longitude"].intValue)
            let WorkStartTime=(json["WorkStartTime"].stringValue)
            let WorkFinishTime=(json["WorkFinishTime"].stringValue)
            let MinutesWorkedInSession_act=(json["MinutesWorkedInSession_act"].intValue)
            let AlertMessage=(json["AlertMessage"].stringValue)
            let PumpAlertFlag=(json["PumpAlertFlag"].boolValue)
            let WaterAlertFlag=(json["WaterAlertFlag"].boolValue)
            let UsingHTFlowInSAModeAlertFlag=(json["UsingHTFlowInSAModeAlertFlag"].boolValue)
            let HTModeEnabled=(json["HTModeEnabled"].boolValue)
            let SAModeEnabled=(json["SAModeEnabled"].boolValue)
            let WorkorderSlotLocationUsed=(json["WorkorderSlotLocationUsed"].stringValue)
            let GeneralNotes=(json["GeneralNotes"].stringValue)
            let LocationNotes=(json["LocationNotes"].stringValue)
            let LastSyncTime=(json["LastSyncTime"].stringValue)
         
            Base.sharedInstance.WorkOrderDetail.append(WorkOrderDetailData.init(EntrySeq: EntrySeq, EntryTime: EntryTime, EntityActive: EntityActive, ViewportCode: ViewportCode, ServiceWorkorderID: ServiceWorkorderID, ServiceWorkorderNumber: ServiceWorkorderNumber, LatestEntry: LatestEntry, ServMgmtGroupID: ServMgmtGroupID, ServMgmtPersonID: ServMgmtPersonID, ServMgmtUserRoleCode: ServMgmtUserRoleCode, ServMgmtUserSubRoleCode: ServMgmtUserSubRoleCode, WorkorderStatusCode: WorkorderStatusCode, InjectionStationID_act: InjectionStationID_act, TermicideTypeCode_act: TermicideTypeCode_act, SoilTypeCode_act: SoilTypeCode_act, SoilTypeRefCode_act: SoilTypeRefCode_act, HT_InjectionCount_act: HT_InjectionCount_act, HT_LinearDistanceApplication_act: HT_LinearDistanceApplication_act, HT_TermicideVolume_act: HT_TermicideVolume_act, HT_WaterVolume_act: HT_WaterVolume_act, HT_PumpVolume_act: Double(HT_PumpVolume_act), HT_InjectorTimer_act: HT_InjectorTimer_act, SA_InjectionCount_act: SA_InjectionCount_act, SA_LinearDistanceApplication_act: SA_LinearDistanceApplication_act, SA_TermicideVolume_act: SA_TermicideVolume_act, SA_WaterVolume_act: SA_WaterVolume_act, SA_PumpVolume_act: Double(SA_PumpVolume_act), SA_InjectorTimer_act: SA_InjectorTimer_act, FlowRate: FlowRate, DosingVolume: DosingVolume, LinearMeasurementUnit_act: LinearMeasurementUnit_act, VolumeMeasurementUnit_act: VolumeMeasurementUnit_act, Latitude: Latitude, Longitude: Longitude, WorkStartTime: WorkStartTime, WorkFinishTime: WorkFinishTime, MinutesWorkedInSession_act: MinutesWorkedInSession_act, AlertMessage: AlertMessage, PumpAlertFlag: PumpAlertFlag, WaterAlertFlag: WaterAlertFlag, UsingHTFlowInSAModeAlertFlag: UsingHTFlowInSAModeAlertFlag, HTModeEnabled: HTModeEnabled, SAModeEnabled: SAModeEnabled, WorkorderSlotLocationUsed: WorkorderSlotLocationUsed, GeneralNotes: GeneralNotes, LocationNotes: LocationNotes, LastSyncTime: LastSyncTime))
            
            let WorkOrderB = WorkOrderBriefData.init(WorkOrderNumber: i, Status: WorkorderStatusCode)
           // print(Base.sharedInstance.WorkOrderDetail.count)

            if(WorkOrderB.status == "H"){
                Base.sharedInstance.onHoldWorkOrder.append(i)
            }
            if(WorkOrderB.status == "O"){
                Base.sharedInstance.openWorkOder.append(i)
            }
            if(WorkOrderB.status == "C"){
                Base.sharedInstance.completeWorkOrder.append(i)
            }
            if(WorkOrderB.status == "N"){
                Base.sharedInstance.newWorkOrder.append(i)
            }
           print("on Hold")
            (Base.sharedInstance.onHoldWorkOrder.count)
        }
        completion(true)
    }


}
}


func LoadWorkOrderList2(Url:String,username:String,password:String,completions: @escaping ( _ success:Bool)->Void){
    var resCount = 1
    var tempCount = 0
    var DetailCount=0
    let inj = "http://stage.evergreen.datacore.us/WorkOrders"
    let headers = [
        "Authorization": "Bearer \(Base.sharedInstance.Token)",
        "Content-Type": "application/X-Access-Token"
    ]
    Alamofire.request(inj, headers: headers).responseJSON { response in
        
        //  print(response)
        let json = JSON(response.result.value!)
        
        if((json["Message"].string as String!) != "Authorization has been denied for this request.")  {
            resCount=json.count
        }
        
        if((json["Message"].string as String!) == "Authorization has been denied for this request."){
            doAuth(username: "test_action3", password:"termite") { (true) in
                LoadWorkOrderList1(Url: "gjsbgjkb", username: username,password:password){(true) in
                    completions(false)
                }
            }
            
        }else {
            
            for (key, subJson) in json {
                tempCount = tempCount+1
                let ServMgmtPersonID = (subJson["ServMgmtPersonID"].string as String!)!
                let ServMgmtUserRoleCode = (subJson["ServMgmtUserRoleCode"].string as String!)!
                let ServMgmtUserSubRoleCode = (subJson["ServMgmtUserSubRoleCode"].string as String!)!
                let ServMgmtGroupID = (subJson["ServMgmtGroupID"].string as String!)!
               let ServiceWorkorderID = (subJson["ServiceWorkorderID"].string as String!)!
                let ServiceWorkorderNumber = (subJson["ServiceWorkorderNumber"].intValue)
                let ServMgmtWorkorderID = (subJson["ServMgmtWorkorderID"].string as String!)!
                let CustomerGroupID = (subJson["CustomerGroupID"].string as String!)!
                let CustomerPersonID = (subJson["CustomerPersonID"].string as String!)!
                let CustomerUserRoleCode = (subJson["CustomerUserRoleCode"].string as String!)!
                let CustomerUserSubRoleCode = (subJson["CustomerUserSubRoleCode"].string as String!)!
                let CustomerFirstName = (subJson["CustomerFirstName"].string as String!)!
                let CustomerLastName = (subJson["CustomerLastName"].string as String!)!
                let LocationTitle = (subJson["LocationTitle"].string as String!)!
                let LocationCode = (subJson["LocationCode"].string as String!)!
                let AddressLine1 = (subJson["AddressLine1"].string as String!)!
                let AddressLine2 = (subJson["AddressLine2"].string as String!)!
                let AttentionLine = (subJson["AttentionLine"].string as String!)!
                let PostalCode = (subJson["PostalCode"].string as String!)!
                let StateProvinceCode = (subJson["StateProvinceCode"].string as String!)!
                let City = (subJson["City"].string as String!)!
                let CountryCode = (subJson["CountryCode"].string as String!)!
                let WOGeneralNotes = (subJson["WOGeneralNotes"].string as String!)!
                let WOLocationNotes = (subJson["WOLocationNotes"].string as String!)!
                //  let GeneralNotes = (subJson["GeneralNotes"].string as String!)!
                let WOAGeneralNotes = (subJson["WOAGeneralNotes"].string as String!)!
                let Billable = (subJson["Billable"].string as String!)!
                let TermicideTypeCode_pln = (subJson["TermicideTypeCode_pln"].string as String!)!
                let SoilTypeCode_pln = (subJson["SoilTypeCode_pln"].string as String!)!
                let SoilTypeRefCode_pln = (subJson["SoilTypeRefCode_pln"].intValue)
                let HT_InjectionCount_pln = (subJson["HT_InjectionCount_pln"].intValue)
                let HT_LinearDistanceApplication_pln = (subJson["HT_LinearDistanceApplication_pln"].intValue)
                let HT_TermicideVolume_pln = (subJson["HT_TermicideVolume_pln"].intValue)
                let HT_WaterVolume_pln = (subJson["HT_WaterVolume_pln"].floatValue)
                let HT_PumpVolume_pln = (subJson["HT_PumpVolume_pln"].floatValue)
                let HT_InjectorTimer_pln = (subJson["HT_InjectorTimer_pln"].floatValue)
                let SA_InjectionCount_pln = (subJson["SA_InjectionCount_pln"].intValue)
                let SA_LinearDistanceApplication_pln = (subJson["SA_LinearDistanceApplication_pln"].intValue)
                let SA_TermicideVolume_pln = (subJson["SA_TermicideVolume_pln"].intValue)
                let SA_WaterVolume_pln = (subJson["SA_WaterVolume_pln"].intValue)
                let SA_PumpVolume_pln = (subJson["SA_PumpVolume_pln"].floatValue)
                let SA_InjectorTimer_pln = (subJson["SA_InjectorTimer_pln"].floatValue)
                let LinearMeasurementUnit_pln = (subJson["LinearMeasurementUnit_pln"].string as String!)!
                let VolumeMeasurementUnit_pln = (subJson["VolumeMeasurementUnit_pln"].string as String!)!
                let MinutesWorkedInSession_pln = (subJson["MinutesWorkedInSession_pln"].intValue)
                let Demo = (subJson["Demo"].string as String!)!
                let EntryTime = (subJson["EntryTime"].string as String!)!
                let LastSyncTime = (subJson["LastSyncTime"].string as String!)!
                let EntityActive = (subJson["EntityActive"].string as String!)!
                let ViewportCode = (subJson["ViewportCode"].string as String!)!
                let ReadyForArchive = (subJson["ReadyForArchive"].string as String!)!
                let isNotTooOld = (subJson["isNotTooOld"].boolValue)
                
                Base.sharedInstance.WorkOrderListObj.append(WorkOrderListData.init(ServiceWorkOrderId: ServiceWorkorderID, ServiceWorkorderNumber: ServiceWorkorderNumber, ServiceManagementWorkorderId: ServMgmtWorkorderID, LocationTitle: LocationTitle, LocationCode: LocationCode, AddressLine1: AddressLine1, AddressLine2: AddressLine2, AttentionLine: AttentionLine, City: City, StateProvinceCode: StateProvinceCode, PostalCode: PostalCode, CountryCode: CountryCode, GeneralNotes: WOAGeneralNotes , LinearDistancePlanned: HT_LinearDistanceApplication_pln, LinearMeasurementUnit: LinearMeasurementUnit_pln, ServMgmtGroupID: ServMgmtGroupID, ServMgmtUserRoleCode: ServMgmtUserRoleCode, ServMgmtPersonID: ServMgmtPersonID, ServMgmtUserSubRoleCode: ServMgmtUserSubRoleCode, Demo: Demo, TermicideTypeCodePlanned: TermicideTypeCode_pln, SoilTypeCodePlanned: SoilTypeCode_pln, VolumeMeasurementUnit: VolumeMeasurementUnit_pln, SyncTime: LastSyncTime))
                
                Base.sharedInstance.WorkOrderID.append(ServiceWorkorderID)
                Base.sharedInstance.WorkOrderIDandStaus.append(workOrderIdandstatusData.init(WorkOrderNumber: ServiceWorkorderID, Address: "\(AddressLine1)\(City)\(StateProvinceCode)"))
                LoadWorkOrderDetail2(Url: "vh", username: "bv v", password: "cvb", completion: { (true) in
                    DetailCount=DetailCount+1
                    if(resCount == DetailCount ){
                      
                    } else {
                        
                        
                    }
                    if(resCount==DetailCount){
                      
                        completions(true)
                    }
                })
                
                
            }
            
        }
        
        
    }
    
    
}

func LoadWorkOrderDetail2(Url:String,username:String,password:String,completion:@escaping ( _ success:Bool)->Void){
    Base.sharedInstance.newWorkOrder.removeAll()
    Base.sharedInstance.completeWorkOrder.removeAll()
    Base.sharedInstance.onHoldWorkOrder.removeAll()
    
    
    var inj2 = "http://stage.evergreen.datacore.us/WorkOrderDetail?WO_Number="
    let headers = [
        "Authorization": "Bearer \(Base.sharedInstance.Token)",
        "Content-Type": "application/X-Access-Token"
    ]
    let currentWorkOrderID=Base.sharedInstance.WorkOrderID.last!
    inj2=inj2+currentWorkOrderID
    Alamofire.request(inj2, headers: headers).responseJSON { response in
        let json = JSON(response.result.value!)
        if((json["Message"].string as String!) == "Authorization has been denied for this request."){
            doAuth(username: "test_action3", password:"termite") { (true) in
                LoadWorkOrderDetail2(Url: "gjsbgjkb", username: username,password:password){(true) in
                }
            }
        }else {
            let WorkorderStatusCode = (json["WorkorderStatusCode"].stringValue)
            let EntrySeq=(json["EntrySeq"].intValue)
            let EntryTime=(json["EntryTime"].stringValue)
            let EntityActive=(json["EntityActive"].stringValue)
            let ViewportCode=(json["ViewportCode"].stringValue)
            let ServiceWorkorderID=(json["ServiceWorkorderID"].stringValue)
            let ServiceWorkorderNumber=(json["ServiceWorkorderNumber"].intValue)
            let LatestEntry=(json["LatestEntry"].stringValue)
            let ServMgmtGroupID=(json["ServMgmtGroupID"].stringValue)
            let ServMgmtPersonID=(json["ServMgmtPersonID"].stringValue)
            let ServMgmtUserRoleCode=(json["ServMgmtUserRoleCode"].stringValue)
            let ServMgmtUserSubRoleCode=(json["ServMgmtUserSubRoleCode"].stringValue)
            let InjectionStationID_act=(json["InjectionStationID_act"].stringValue)
            let TermicideTypeCode_act=(json["TermicideTypeCode_act"].stringValue)
            let SoilTypeCode_act=(json["SoilTypeCode_act"].stringValue)
            let SoilTypeRefCode_act=(json["SoilTypeRefCode_act"].intValue)
            let HT_InjectionCount_act=(json["HT_InjectionCount_act"].intValue)
            let HT_LinearDistanceApplication_act=(json["HT_LinearDistanceApplication_act"].intValue)
            let HT_TermicideVolume_act=(json["HT_TermicideVolume_act"].intValue)
            let HT_WaterVolume_act=(json["HT_WaterVolume_act"].intValue)
            let HT_PumpVolume_act=(json["HT_PumpVolume_act"].doubleValue)
            let HT_InjectorTimer_act=(json["HT_InjectorTimer_act"].intValue)
            let SA_InjectionCount_act=(json["SA_InjectionCount_act"].intValue)
            let SA_LinearDistanceApplication_act=(json["SA_LinearDistanceApplication_act"].intValue)
            let SA_TermicideVolume_act=(json["SA_TermicideVolume_act"].intValue)
            let SA_WaterVolume_act=(json["SA_WaterVolume_act"].intValue)
            let SA_PumpVolume_act=(json["SA_PumpVolume_act"].doubleValue)
            let SA_InjectorTimer_act=(json["SA_InjectorTimer_act"].intValue)
            let FlowRate=(json["FlowRate"].intValue)
            let DosingVolume=(json["DosingVolume"].intValue)
            let LinearMeasurementUnit_act=(json["LinearMeasurementUnit_act"].stringValue)
            let VolumeMeasurementUnit_act=(json["VolumeMeasurementUnit_act"].stringValue)
            let Latitude=(json["Latitude"].intValue)
            let Longitude=(json["Longitude"].intValue)
            let WorkStartTime=(json["WorkStartTime"].stringValue)
            let WorkFinishTime=(json["WorkFinishTime"].stringValue)
            let MinutesWorkedInSession_act=(json["MinutesWorkedInSession_act"].intValue)
            let AlertMessage=(json["AlertMessage"].stringValue)
            let PumpAlertFlag=(json["PumpAlertFlag"].boolValue)
            let WaterAlertFlag=(json["WaterAlertFlag"].boolValue)
            let UsingHTFlowInSAModeAlertFlag=(json["UsingHTFlowInSAModeAlertFlag"].boolValue)
            let HTModeEnabled=(json["HTModeEnabled"].boolValue)
            let SAModeEnabled=(json["SAModeEnabled"].boolValue)
            let WorkorderSlotLocationUsed=(json["WorkorderSlotLocationUsed"].stringValue)
            let GeneralNotes=(json["GeneralNotes"].stringValue)
            let LocationNotes=(json["LocationNotes"].stringValue)
            let LastSyncTime=(json["LastSyncTime"].stringValue)
            Base.sharedInstance.WorkOrderDetail.append(WorkOrderDetailData.init(EntrySeq: EntrySeq, EntryTime: EntryTime, EntityActive: EntityActive, ViewportCode: ViewportCode, ServiceWorkorderID: ServiceWorkorderID, ServiceWorkorderNumber: ServiceWorkorderNumber, LatestEntry: LatestEntry, ServMgmtGroupID: ServMgmtGroupID, ServMgmtPersonID: ServMgmtPersonID, ServMgmtUserRoleCode: ServMgmtUserRoleCode, ServMgmtUserSubRoleCode: ServMgmtUserSubRoleCode, WorkorderStatusCode: WorkorderStatusCode, InjectionStationID_act: InjectionStationID_act, TermicideTypeCode_act: TermicideTypeCode_act, SoilTypeCode_act: SoilTypeCode_act, SoilTypeRefCode_act: SoilTypeRefCode_act, HT_InjectionCount_act: HT_InjectionCount_act, HT_LinearDistanceApplication_act: HT_LinearDistanceApplication_act, HT_TermicideVolume_act: HT_TermicideVolume_act, HT_WaterVolume_act: HT_WaterVolume_act, HT_PumpVolume_act: Double(HT_PumpVolume_act), HT_InjectorTimer_act: HT_InjectorTimer_act, SA_InjectionCount_act: SA_InjectionCount_act, SA_LinearDistanceApplication_act: SA_LinearDistanceApplication_act, SA_TermicideVolume_act: SA_TermicideVolume_act, SA_WaterVolume_act: SA_WaterVolume_act, SA_PumpVolume_act: Double(SA_PumpVolume_act), SA_InjectorTimer_act: SA_InjectorTimer_act, FlowRate: FlowRate, DosingVolume: DosingVolume, LinearMeasurementUnit_act: LinearMeasurementUnit_act, VolumeMeasurementUnit_act: VolumeMeasurementUnit_act, Latitude: Latitude, Longitude: Longitude, WorkStartTime: WorkStartTime, WorkFinishTime: WorkFinishTime, MinutesWorkedInSession_act: MinutesWorkedInSession_act, AlertMessage: AlertMessage, PumpAlertFlag: PumpAlertFlag, WaterAlertFlag: WaterAlertFlag, UsingHTFlowInSAModeAlertFlag: UsingHTFlowInSAModeAlertFlag, HTModeEnabled: HTModeEnabled, SAModeEnabled: SAModeEnabled, WorkorderSlotLocationUsed: WorkorderSlotLocationUsed, GeneralNotes: GeneralNotes, LocationNotes: LocationNotes, LastSyncTime: LastSyncTime))
           //print(Base.sharedInstance.WorkOrderDetail)
            
            let WorkOrderB = WorkOrderBriefData.init(WorkOrderNumber: currentWorkOrderID, Status: WorkorderStatusCode)
            if(WorkOrderB.status == "H"){
                Base.sharedInstance.onHoldWorkOrder.append(currentWorkOrderID)
            }
            if(WorkOrderB.status == "O"){
                Base.sharedInstance.openWorkOder.append(currentWorkOrderID)
            }
            if(WorkOrderB.status == "C"){
                Base.sharedInstance.completeWorkOrder.append(currentWorkOrderID)
            }
            if(WorkOrderB.status == "N"){
                Base.sharedInstance.newWorkOrder.append(currentWorkOrderID)
            }
        }
        completion(true)
    }
    
    
}



    

 


