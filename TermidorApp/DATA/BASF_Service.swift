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
            //print(token)
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
                completion(true)
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

