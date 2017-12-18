//
//  InjectionStation.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/7/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import Foundation
public struct InjectionStationData{
    var injectionStationID: String? = nil
    var injectionStationName: String? = nil
    var controllerIPAddress: String? = nil
    var iPAddress: String? = nil
    init(InjectionStationID:String,InjectionStationName:String,ControllerIPAddress:String,IPAddress:String){
        self.injectionStationID = InjectionStationID
        self.iPAddress = IPAddress
        self.injectionStationName = InjectionStationName
        self.controllerIPAddress = ControllerIPAddress
    }
}
