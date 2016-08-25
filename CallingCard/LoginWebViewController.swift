//
//  LoginWebViewController.swift
//  CallingCard
//
//  Created by Jake Alsemgeest on 2016-08-24.
//  Copyright © 2016 Jalsemgeest. All rights reserved.
//

import UIKit

class LoginWebViewController: UIViewController, UIWebViewDelegate {

    
    // MARK: IBOutlets
    @IBOutlet weak var webView: UIWebView! {
        didSet {
            webView.delegate = self;
        }
    }
    
    // MARK: Constants
    
    let linkedInKey = "77141wm30yw4kl"
    
    let linkedInSecret = "6NyDvJQFMGXuNi8b"
    
    let authorizationEndPoint = "https://www.linkedin.com/uas/oauth2/authorization"
    
    let accessTokenEndPoint = "https://www.linkedin.com/uas/oauth2/accessToken"
    
    // MARK: Helper Functions
    
    func startAuthorization() {
        // Specify the response type which should always be "code".
        let responseType = "code"
        
        // Set the redirect URL. Adding the percent escape characthers is necessary.
        let redirectURL = "https://com.jalsemgeest.callingcard/oauth2".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())!
        
        // Create a random string based on the time interval (it will be in the form linkedin12345679).
        let state = "linkedin-oauth2\(Int(NSDate().timeIntervalSince1970))"
        
        // Set preferred scope.
        let scope = "r_basicprofile,r_emailaddress"
        
        var authorizationURL = "\(authorizationEndPoint)?"
        authorizationURL += "response_type=\(responseType)&"
        authorizationURL += "client_id=\(linkedInKey)&"
        authorizationURL += "redirect_uri=\(redirectURL)&"
        authorizationURL += "state=\(state)&"
        authorizationURL += "scope=\(scope)"
        
        print(authorizationURL)
        
        // Create a URL request and load it in the web view.
        let request = NSURLRequest(URL: NSURL(string: authorizationURL)!)
        webView.loadRequest(request)
    }
    
    func requestForAccessToken(authorizationCode: String) {
        let grantType = "authorization_code"
        
        let redirectURL = "https://com.jalsemgeest.callingcard/oauth2".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())!
        
        // Set the POST parameters.
        var postParams = "grant_type=\(grantType)&"
        postParams += "code=\(authorizationCode)&"
        postParams += "redirect_uri=\(redirectURL)&"
        postParams += "client_id=\(linkedInKey)&"
        postParams += "client_secret=\(linkedInSecret)"
        
        // Convert the POST parameters into a NSData object.
        let postData = postParams.dataUsingEncoding(NSUTF8StringEncoding)
        
        // Initialize a mutable URL request object using the access token endpoint URL string.
        let request = NSMutableURLRequest(URL: NSURL(string: accessTokenEndPoint)!)

        // Indicate that we're about to make a POST request.
        request.HTTPMethod = "POST"
        
        // Set the HTTP body using the postData object created above.
        request.HTTPBody = postData
        
        // Add the required HTTP header field.
        request.addValue("application/x-www-form-urlencoded;", forHTTPHeaderField: "Content-Type")

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
                    
                    let accessToken = dataDictionary["access_token"] as! String
                    
                    NSUserDefaults.standardUserDefaults().setObject(accessToken, forKey: "LIAccessToken")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    // This must happen in the main thread.
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    })
                }
                catch {
                    print("Could not convert JSON data into a dictionary.")
                }
            }
        }
        
        task.resume()
    }
    
    // MARK: Delegate Functions
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.URL!
        print(url)
        
        if url.host == "com.jalsemgeest.callingcard" {
            if url.absoluteString.rangeOfString("code") != nil {
                let urlParts = url.absoluteString.componentsSeparatedByString("?")
                let code = urlParts[1].componentsSeparatedByString("=")[1]
                
                requestForAccessToken(code)
            }
        }
        
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAuthorization()
    }

    // MARK: IBActions
    @IBAction func goBack(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
