//
//  TermicideType+CoreDataProperties.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/6/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//
//

import Foundation
import CoreData


extension TermicideType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TermicideType> {
        return NSFetchRequest<TermicideType>(entityName: "TermicideType")
    }

    @NSManaged public var termicideTypeCode: String?
    @NSManaged public var termicideTypeName: String?
    @NSManaged public var dilutionRatio: String?
    @NSManaged public var injectionCountFactor: String?

}
