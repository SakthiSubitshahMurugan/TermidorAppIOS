//
//  File.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/30/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import Foundation
public struct workOrderIdandstatusData{
    var workOrderNumber:String?
    var Address:String?
    init(WorkOrderNumber:String,Address:String){
        self.workOrderNumber = WorkOrderNumber
        self.Address = Address
    }
}
