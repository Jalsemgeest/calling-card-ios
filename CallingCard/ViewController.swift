//
//  ViewController.swift
//  CallingCard
//
//  Created by Jake Alsemgeest on 2016-08-24.
//  Copyright © 2016 Jalsemgeest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: User
    var user : User? = nil
    
    // MARK: IBOutlets
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var getDataButton: UIButton!
    
    @IBOutlet weak var urlButton: UIButton!
    
    // MARK: IBActions
    
    @IBAction func goToUrl() {
        let profileURL = NSURL(string: urlButton.titleForState(UIControlState.Normal)!)
        UIApplication.sharedApplication().openURL(profileURL!)
    }
    
    @IBAction func getLinkedInData() {
        if let accessToken = NSUserDefaults.standardUserDefaults().objectForKey("LIAccessToken") {
            // Specify the URL string that we'll get the profile info from.
//            let targetURLString = "https://api.linkedin.com/v1/people/~:(public-profile-url)?format=json"
//            let targetURLString = "https://api.linkedin.com/v1/people/~:(first-name,last-name,email-address,public-profile-url,headline,industry,location,picture-url)?format=json"
            let targetURLString = "https://api.linkedin.com/v1/people/~:(first-name,last-name,formatted-name,summary,specialties,positions,email-address,headline,location,public-profile-url,industry,picture-url)?format=json"
            // first-name,last-name,email-address,public-profile-url,headline,industry,location,picture-url
            // Initialize a mutable URL request object.
            let request = NSMutableURLRequest(URL: NSURL(string: targetURLString)!)
            
            // Indicate that this is a GET request.
            request.HTTPMethod = "GET"
            
            // Add the access token as an HTTP header field.
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

            // Initialize a NSURLSession object.
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            // Make the request.
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
                
                // Get the HTTP status code of the request.
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                
                if statusCode == 200 {
                    // Convert the received JSON data into a dictionary.
                    do {
                        let dataDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                        
//                        let profileURLString = dataDictionary["publicProfileUrl"] as! String
                        
//                        let name = dataDictionary["firstName"] as! String
                        
//                        print(profileURLString)
                        
                        // Make changes as needed
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.user = User(dict: dataDictionary as! NSDictionary)
                            self.urlButton.setTitle(self.user?.publicProfileUrl, forState: UIControlState.Normal)
                            self.urlButton.hidden = false
                            
                        })
                    }
                    catch {
                        print("Could not convert JSON data into a dictionary.")
                    }
                }
                
            }
            
            task.resume()
        }
    }
    
    // MARK: Helper Functions
    
    func checkForExistingAccessToken() {
        if NSUserDefaults.standardUserDefaults().objectForKey("LIAccessToken") != nil {
            loginButton.enabled = false
            getDataButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        checkForExistingAccessToken()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataButton.enabled = false
        urlButton.hidden = true
    }
}

