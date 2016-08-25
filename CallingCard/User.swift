//
//  User.swift
//  CallingCard
//
//  Created by Jake Alsemgeest on 2016-08-24.
//  Copyright © 2016 Jalsemgeest. All rights reserved.
//
import UIKit

class User {
    
    var firstName : String!
    var lastName : String!
    var email : String!
    var formattedName : String!
    var headline : String!
    var industry : String!
    // Change location to model
    var location : String!
    
    var imageUrl : String!
    
    // Change to array of position objects
    var positions : String!
    
    var publicProfileUrl : String!
//    
    init(dict: NSDictionary!) {
        self.firstName = dict["firstName"] as! String
        self.lastName = dict["lastName"] as! String
        self.publicProfileUrl = dict["publicProfileUrl"] as! String
        self.email = dict["emailAddress"] as! String
        self.formattedName = dict["formattedName"] as! String
        self.headline = dict["headline"] as! String
        self.industry = dict["industry"] as! String
        self.imageUrl = dict["pictureUrl"] as! String
        
        self.location = "Test"
        
    }
    
}
