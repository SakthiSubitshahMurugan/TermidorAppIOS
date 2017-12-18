//
//  User.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/6/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public struct User
{
    var password: String? = nil
    var personID: String? = nil
    var userRoleCode: String? = nil
    var userSubRoleCode: String? = nil
    var groupID: String? = nil
    var groupName:String? = nil
    var firstName:String? = nil
    var lastName:String? = nil
    var canDoTraining:String? = nil
    var remoteValidationRequired:String? = nil
    var mobileAppVersion:String? = nil
    var rememberMe:String? = nil
    var isServiceAvailable:String?=nil
    var isOnline:String?=nil
    init (Username:String,Password:String,PersonID:String,
          UserRoleCode:String,UserSubRoleCode:String,GroupID:String,
          GroupName:String,FirstName:String, LastName:String,RememberMe:String,
          CanDoTraining:String, RemoteValidationRequired:String,IsOnline:String,MobileAppVersion:String) {
        self.password = Password;
        self.personID = PersonID;
        self.userRoleCode = UserRoleCode;
        self.userSubRoleCode = UserSubRoleCode;
        self.groupID = GroupID;
        self.groupName = GroupName;
        self.firstName = FirstName;
        self.lastName = LastName;
        self.canDoTraining = CanDoTraining;
        self.mobileAppVersion = MobileAppVersion;
        self.remoteValidationRequired = RemoteValidationRequired;
        self.rememberMe = RememberMe
       // self.isOnline = IsServiceAvailable
        self.isOnline = IsOnline
    }

}

