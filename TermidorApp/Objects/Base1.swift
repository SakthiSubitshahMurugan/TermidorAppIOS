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
    var TermicidetypeObj = [TermicideTypeData]()
    var ServiceAvailabilty:String?
    var result:String?
}
