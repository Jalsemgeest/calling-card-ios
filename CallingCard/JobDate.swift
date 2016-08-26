//
//  JobDate.swift
//  CallingCard
//
//  Created by Jake Alsemgeest on 2016-08-25.
//  Copyright © 2016 Jalsemgeest. All rights reserved.
//

import UIKit

class JobDate {
    
    let month : Int!
    let year : Int!
    
    init(dict: NSDictionary!) {
        self.month = dict["month"] as! Int
        self.year = dict["year"] as! Int
    }
    
}
