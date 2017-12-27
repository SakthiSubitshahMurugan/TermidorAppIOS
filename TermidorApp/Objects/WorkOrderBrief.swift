//
//  WorkOrderBrief.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/27/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import Foundation
public struct WorkOrderBriefData{
    var workOrderNumber:String?
    var status:String?
    init(WorkOrderNumber:String,Status:String){
        self.workOrderNumber = WorkOrderNumber
        self.status = Status
    }
}

