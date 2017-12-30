//
//  WorkOrderDetail.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/27/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import Foundation
public struct WorkOrderDetailData{
    var entrySeq:Int;
    var entryTime:String;
    var entityActive:String;
    var viewportCode:String;
    var serviceWorkorderID:String
    var serviceWorkorderNumber:Int;
    var latestEntry:String;
    var servMgmtGroupID:String;
    var servMgmtPersonID:String;
    var servMgmtUserRoleCode:String;
    var servMgmtUserSubRoleCode:String;
    var workorderStatusCode:String;
    var injectionStationID_act:String;
    var termicideTypeCode_act:String;
    var soilTypeCode_act:String;
    var soilTypeRefCode_act:Int;
    var hT_InjectionCount_act:Int
    var hT_LinearDistanceApplication_act:Int
    var hT_TermicideVolume_act:Int
    var hT_WaterVolume_act:Int
    var hT_PumpVolume_act:Double;
    var hT_InjectorTimer_act:Int;
    var sA_InjectionCount_act:Int
    var sA_LinearDistanceApplication_act:Int;
    var sA_TermicideVolume_act:Int;
    var sA_WaterVolume_act:Int;
    var sA_PumpVolume_act:Double;
    var sA_InjectorTimer_act:Int;
    var flowRate:Int
    var dosingVolume:Int
    var linearMeasurementUnit_act:String
    var volumeMeasurementUnit_act:String
    var latitude:Int
    var longitude:Int
    var workStartTime:String
    var workFinishTime:String
    var minutesWorkedInSession_act:Int
    var alertMessage:String
    var pumpAlertFlag:Bool
    var waterAlertFlag:Bool
    var usingHTFlowInSAModeAlertFlag:Bool
    var hTModeEnabled:Bool
    var sAModeEnabled:Bool
    var workorderSlotLocationUsed:String
    var generalNotes:String
    var locationNotes:String
    var lastSyncTime:String
    
    init( EntrySeq:Int,EntryTime:String,EntityActive:String,ViewportCode:String,ServiceWorkorderID:String,
ServiceWorkorderNumber:Int,LatestEntry:String,ServMgmtGroupID:String,ServMgmtPersonID:String,ServMgmtUserRoleCode:String,ServMgmtUserSubRoleCode:String,WorkorderStatusCode:String,InjectionStationID_act:String,TermicideTypeCode_act:String,SoilTypeCode_act:String,SoilTypeRefCode_act:Int,HT_InjectionCount_act:Int,HT_LinearDistanceApplication_act:Int,HT_TermicideVolume_act:Int,HT_WaterVolume_act:Int,HT_PumpVolume_act:Double,HT_InjectorTimer_act:Int,SA_InjectionCount_act:Int,SA_LinearDistanceApplication_act:Int,SA_TermicideVolume_act:Int,SA_WaterVolume_act:Int,SA_PumpVolume_act:Double,SA_InjectorTimer_act:Int,FlowRate:Int,DosingVolume:Int,LinearMeasurementUnit_act:String,VolumeMeasurementUnit_act:String,Latitude:Int,Longitude:Int,WorkStartTime:String,WorkFinishTime:String,MinutesWorkedInSession_act:Int,AlertMessage:String,PumpAlertFlag:Bool,WaterAlertFlag:Bool,UsingHTFlowInSAModeAlertFlag:Bool,HTModeEnabled:Bool,SAModeEnabled:Bool,WorkorderSlotLocationUsed:String,GeneralNotes:String,LocationNotes:String,LastSyncTime:String) {
        self.entrySeq = EntrySeq
        self.entryTime = EntryTime
        self.entityActive = EntityActive
        self.viewportCode = ViewportCode
        self.serviceWorkorderID = ServiceWorkorderID
        self.serviceWorkorderNumber = ServiceWorkorderNumber
        self.latestEntry = LatestEntry
        self.servMgmtGroupID = ServMgmtGroupID
        self.servMgmtPersonID = ServMgmtPersonID
        self.servMgmtUserRoleCode = ServMgmtUserRoleCode
        self.servMgmtUserSubRoleCode = ServMgmtUserSubRoleCode
        self.workorderStatusCode = WorkorderStatusCode
        self.injectionStationID_act = InjectionStationID_act
        self.termicideTypeCode_act = TermicideTypeCode_act
        self.soilTypeCode_act = SoilTypeCode_act
        self.soilTypeRefCode_act = SoilTypeRefCode_act
        self.hT_InjectionCount_act = HT_InjectionCount_act
        self.hT_LinearDistanceApplication_act = HT_LinearDistanceApplication_act
        self.hT_TermicideVolume_act = HT_TermicideVolume_act
        self.hT_WaterVolume_act = HT_WaterVolume_act
        self.hT_PumpVolume_act = HT_PumpVolume_act
        self.hT_InjectorTimer_act=HT_InjectorTimer_act
        self.sA_InjectionCount_act=SA_InjectionCount_act
        self.sA_LinearDistanceApplication_act=SA_LinearDistanceApplication_act
        self.sA_TermicideVolume_act=SA_TermicideVolume_act
        self.sA_WaterVolume_act=SA_WaterVolume_act
        self.sA_PumpVolume_act=SA_PumpVolume_act
        self.sA_InjectorTimer_act=SA_InjectorTimer_act
        self.flowRate=FlowRate
        self.dosingVolume=DosingVolume
        self.linearMeasurementUnit_act=LinearMeasurementUnit_act
        self.volumeMeasurementUnit_act=VolumeMeasurementUnit_act
        self.latitude=Latitude
        self.longitude=Longitude
        self.workStartTime=WorkStartTime
        self.workFinishTime=WorkFinishTime
        self.minutesWorkedInSession_act=MinutesWorkedInSession_act
        self.alertMessage=AlertMessage
        self.pumpAlertFlag=PumpAlertFlag
        self.waterAlertFlag=WaterAlertFlag
        self.usingHTFlowInSAModeAlertFlag=UsingHTFlowInSAModeAlertFlag
        self.hTModeEnabled=HTModeEnabled
        self.sAModeEnabled=SAModeEnabled
        self.workorderSlotLocationUsed=WorkorderSlotLocationUsed
        self.generalNotes=GeneralNotes
        self.locationNotes=LocationNotes
        self.lastSyncTime=LastSyncTime
        
        
        
        
    }

}
