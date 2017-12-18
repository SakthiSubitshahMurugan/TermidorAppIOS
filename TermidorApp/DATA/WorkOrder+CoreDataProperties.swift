//
//  WorkOrder+CoreDataProperties.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/18/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//
//

import Foundation
import CoreData


extension WorkOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkOrder> {
        return NSFetchRequest<WorkOrder>(entityName: "WorkOrder")
    }

    @NSManaged public var addressLine1: String?
    @NSManaged public var addressLine2: String?
    @NSManaged public var attentionLine: String?
    @NSManaged public var billable: String?
    @NSManaged public var city: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var customerFirstName: String?
    @NSManaged public var customerGroupID: String?
    @NSManaged public var customerLastName: String?
    @NSManaged public var customerPersonID: String?
    @NSManaged public var customerUserRoleCode: String?
    @NSManaged public var customerUserSubRoleCode: String?
    @NSManaged public var demo: String?
    @NSManaged public var entityActive: String?
    @NSManaged public var entryTime: String?
    @NSManaged public var generalNotes: String?
    @NSManaged public var groupName: String?
    @NSManaged public var hT_InjectionCount_pln: Double
    @NSManaged public var hT_InjectorTimer_pln: Double
    @NSManaged public var hT_LinearDistanceApplication_pln: Double
    @NSManaged public var hT_TermicideVolume_pln: Double
    @NSManaged public var hT_WaterVolume_pln: Double
    @NSManaged public var isNotTooOld: Bool
    @NSManaged public var lastSyncTime: String?
    @NSManaged public var linearMeasurementUnit_pln: String?
    @NSManaged public var locationCode: String?
    @NSManaged public var locationTitle: String?
    @NSManaged public var minutesWorkedInSession_pln: Double
    @NSManaged public var postalCode: String?
    @NSManaged public var readyForArchive: String?
    @NSManaged public var sA_InjectionCount_pln: Double
    @NSManaged public var sA_InjectorTimer_pln: Double
    @NSManaged public var sA_LinearDistanceApplication_pln: Double
    @NSManaged public var sA_PumpVolume_pln: Double
    @NSManaged public var sA_TermicideVolume_pln: Double
    @NSManaged public var sA_WaterVolume_pln: Double
    @NSManaged public var serviceWorkorderID: String?
    @NSManaged public var serviceWorkorderNumber: Int64
    @NSManaged public var servMgmtGroupID: String?
    @NSManaged public var servMgmtPersonID: String?
    @NSManaged public var servMgmtUserRoleCode: String?
    @NSManaged public var servMgmtUserSubRoleCode: String?
    @NSManaged public var servMgmtWorkorderID: String?
    @NSManaged public var soilTypeCode_pln: String?
    @NSManaged public var soilTypeRefCode_pln: Double
    @NSManaged public var stateProvinceCode: String?
    @NSManaged public var termicideTypeCode_pln: String?
    @NSManaged public var viewportCode: String?
    @NSManaged public var volumeMeasurementUnit_pln: String?
    @NSManaged public var wOAGeneralNotes: String?
    @NSManaged public var wOGeneralNotes: String?
    @NSManaged public var wOLocationNotes: String?

}
