//
//  InjectionStation+CoreDataProperties.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/6/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//
//

import Foundation
import CoreData


extension InjectionStation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InjectionStation> {
        return NSFetchRequest<InjectionStation>(entityName: "InjectionStation")
    }

    @NSManaged public var injectionStationID: String?
    @NSManaged public var injectionStationName: String?
    @NSManaged public var controllerIPAddress: String?
    @NSManaged public var iPAddress: String?

}
