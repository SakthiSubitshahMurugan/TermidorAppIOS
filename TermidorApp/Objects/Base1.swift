//
//  Base1.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/6/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import Foundation
class Base:NSObject{
    static let sharedInstance = Base()
    private override init() {}
    var Token:String = "NA"
    var Global:User?
    var InjectionStationObj = [InjectionStationData]()
    var updatedWorkOrderIDs=[String]()
    var TermicidetypeObj = [TermicideTypeData]()
    var ServiceAvailabilty:String?
    var result:String?
    var WorkOrderDetail=[WorkOrderDetailData]()
    var WorkOrderListObj=[WorkOrderListData]()
    var WorkOrderID=[String]()
    var WorkOrderBriefObj=[WorkOrderBriefData]()
    var newWorkOrder = [String]()
    var openWorkOder = [String]()
    var onHoldWorkOrder = [String]()
    var assingedWorkOrder = [String]()
    var completeWorkOrder = [String]()
    var WorkOrderIDandStaus=[workOrderIdandstatusData]()
    var SyncTime:String = "1970-01-01 00:00:00"

}
