//
//  User+CoreDataProperties.swift
//  CallingCard
//
//  Created by Jake Alsemgeest on 2016-08-25.
//  Copyright © 2016 Jalsemgeest. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var formattedName: String?
    @NSManaged var email: String?
    @NSManaged var headline: String?
    @NSManaged var industry: String?
    @NSManaged var imageUrl: String?
    @NSManaged var publicProfileUrl: String?
    @NSManaged var positions: NSSet?
    @NSManaged var location: Location?

}
