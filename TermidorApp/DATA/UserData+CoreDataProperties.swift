//
//  UserData+CoreDataProperties.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/6/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var userName: String?
    @NSManaged public var password: String?
    @NSManaged public var personID: String?
    @NSManaged public var userRoleCode: String?
    @NSManaged public var userSubRoleCode: String?
    @NSManaged public var groupID: String?
    @NSManaged public var groupName: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var canDoTraining: String?
    @NSManaged public var remoteValidationRequired: String?
    @NSManaged public var mobileAppVersion: String?
    @NSManaged public var rememberMe: String?

}
