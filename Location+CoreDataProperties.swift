//
//  Location+CoreDataProperties.swift
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

extension Location {

    @NSManaged var countryCode: String?
    @NSManaged var country: String?
    @NSManaged var city: String?
    @NSManaged var user: NSSet?
    @NSManaged var job: NSSet?

}
