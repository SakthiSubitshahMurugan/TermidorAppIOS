//
//  WorkOrderObject.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/18/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import Foundation

public struct WorkOrderListData{
var serviceWorkOrderId:String?
var serviceWorkorderNumber:Int?
var serviceManagementWorkorderId:String?
var locationTitle:String?
var locationCode:String?
var addressLine1:String?
var addressLine2:String?
var attentionLine:String?
var city:String?
var stateProvinceCode:String?
var postalCode:String?
var countryCode:String?
var generalNotes:String?
var workorderStatusCode:String?
var linearDistancePlanned:Double?
var linearMeasurementUnit:String?
var servMgmtGroupID:String?
var servMgmtPersonID:String?
var servMgmtUserRoleCode:String?
var servMgmtUserSubRoleCode:String?
var demo:String?
var termicideTypeCodePlanned:String?
var soilTypeCodePlanned:String?
var volumeMeasurementUnit:String?
var syncTime:String?
init(ServiceWorkOrderId:String,ServiceWorkorderNumber:Int,ServiceManagementWorkorderId:String,LocationTitle:String,LocationCode:String,AddressLine1:String,AddressLine2:String,AttentionLine:String,City:String,StateProvinceCode:String,PostalCode:String,CountryCode:String,GeneralNotes:String,WorkorderStatusCode:String,LinearDistancePlanned:Double,LinearMeasurementUnit:String,ServMgmtGroupID:String,ServMgmtUserRoleCode:String,ServMgmtPersonID:String,ServMgmtUserSubRoleCode:String,Demo:String,TermicideTypeCodePlanned:String,SoilTypeCodePlanned:String,VolumeMeasurementUnit:String,SyncTime:String){
    
        self.serviceWorkOrderId = ServiceWorkOrderId
        self.serviceWorkorderNumber = ServiceWorkorderNumber
        self.serviceManagementWorkorderId = ServiceManagementWorkorderId
        self.locationTitle = LocationTitle
        self.locationCode = LocationCode
        self.addressLine1 = AddressLine1
        self.addressLine2 = AddressLine2
        self.attentionLine = AttentionLine
        self.city = City
        self.stateProvinceCode = StateProvinceCode
        self.postalCode = PostalCode
        self.countryCode = CountryCode
        self.generalNotes = GeneralNotes
        self.workorderStatusCode = WorkorderStatusCode
        self.linearDistancePlanned = LinearDistancePlanned
        self.linearMeasurementUnit = LinearMeasurementUnit
        self.servMgmtGroupID = ServMgmtGroupID
        self.servMgmtUserRoleCode = ServMgmtUserSubRoleCode
        self.servMgmtPersonID = ServMgmtPersonID
        self.servMgmtUserSubRoleCode = ServMgmtUserSubRoleCode
        self.demo = Demo
        self.termicideTypeCodePlanned = TermicideTypeCodePlanned
        self.soilTypeCodePlanned = SoilTypeCodePlanned
        self.volumeMeasurementUnit = VolumeMeasurementUnit
        self.syncTime = SyncTime
    }
}
