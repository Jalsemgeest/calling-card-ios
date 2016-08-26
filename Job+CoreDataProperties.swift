//
//  Job+CoreDataProperties.swift
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

extension Job {

    @NSManaged var workplace: String?
    @NSManaged var industry: String?
    @NSManaged var type: String?
    @NSManaged var title: String?
    @NSManaged var startDate: NSDate?
    @NSManaged var endDate: NSDate?
    @NSManaged var location: Location?
    @NSManaged var user: NSSet?

}
