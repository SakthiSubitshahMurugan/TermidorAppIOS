//
//  WorkOrderDetail.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/27/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import Foundation
public struct WorkOrderDetailData{
    var EntryTime:Int;
    var SyncStatus:String;
    var SyncTime:String;
    var ServiceWorkorderID:String;
    var TechnicianGroupID:String
    var TechnicianPersonID:String;
    var TechnicianUserRoleCode:String;
    var TechnicianUserSubRoleCode:String;
    var WorkorderStatusCode:String;
    var InjectionStationID_act:String;
    var InjectionDisplayFirmwareVersion:String;
    var ControllerFirmwareVersion:String;
    var BaseDisplayFirmwareVersion:String;
    var TermicideTypeCode_act:String;
    var TermicideTypeName_act:String;
    var  SoilTypeCode_act:String;
    var  SoilTypeRefCode_act:String;
    var HT_InjectionCount_act:String;
    var HT_LinearDistanceApplication_act:String;
    var HT_TermicideVolume_act:String;
    var HT_WaterVolume_act:String;
    var HT_PumpVolume_act:String;
    var HT_InjectorTimer_act:String;
    var SA_TermicideVolume_act:String;
    var SA_WaterVolume_act:String;
    var SA_PumpVolume_act:String;
    var LinearMeasurementUnit_act:String;
    var VolumeMeasurementUnit_act:String;
    var Latitude:String;
    var Longitude:String;
    var WorkStartTime:String;
    var WorkFinishTime:String;
    var WorkStartTimeDate:String;
    var WorkStartTimeTime:String;
    var MinutesWorkedInSession_act:String;
    var AlertMessage:String;
    var PumpAlertFlag:String;
    var WaterAlertFlag:String;
    var UsingHTFlowInSAModeAlertFlag:String
    var HTModeEnabled:String
    var SAModeEnabled:String
    var WorkorderSlotLocationUsed:String
    var WOEGeneralNotes:String
    var WOELocationNotes:String
}
