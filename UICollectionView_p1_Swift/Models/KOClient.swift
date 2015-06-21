//
//  KOClient.swift
//  KODemo
//
//  Created by Michael Walter on 13.06.15.
//  Copyright (c) 2015 Michael Walter. All rights reserved.
//

import Foundation

class KOClient {

    var usernameko = "13014"
    var passwordko = "12345678"
    var urlPath = "http://192.168.1.15:1210"
    
    var User_Token = ""
 
    var TransportStatusList = [NSDictionary]()
    
    func GetTransportStatusList() {
    
    var urlDataPath = urlPath + "/Transports/GetTransportStatusList?startrow=1&maxrowcount=100"
    var url = NSURL(string: urlDataPath)
    
    //var session = NSURLSession.sharedSession()
    
    let _config = NSURLSessionConfiguration.defaultSessionConfiguration()
    //let userPasswordString = "username@gmail.com:password"
    //let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
    //let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
    let authString = "Bearer \(self.User_Token)"
    _config.HTTPAdditionalHeaders = ["Authorization" : authString]
    let session = NSURLSession(configuration: _config)
    
    var task = session.dataTaskWithURL(url!,
        completionHandler: {
        data,
        response,
        error -> Void in
        
        println("Task completed")
        
        if(error != nil) {
            println(error.localizedDescription)
        } else {
            
            
            var err: NSError?
            
            var results = NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.MutableContainers,
                error: &err) as! NSArray
            
            if(err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            
            println("\(results.count) JSON rows returned and parsed into an array")
            
            self.TransportStatusList = results as! [(NSDictionary)]
            
            if (results.count != 0) {
                // For this example just spit out the first item "event" entry
                var rowData: NSDictionary = results[0] as! NSDictionary
                var data = rowData["TransportStatus_Code"] as! NSInteger;
                var data1 = rowData["Order_InternNumber"] as! NSString;
                println("Status \(data) \(data1) out")
            } else {
                println("No rows returned")
            }
        }
        })
    
    task.resume()
    }
    
    func Login() {

        var urlLoginPath = urlPath + "/Account/Login?username=" + usernameko + "&password=" + passwordko
        var url = NSURL(string: urlLoginPath)
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(url!,
            completionHandler: {
                data,
                response,
                error -> Void in
                
                println("Task completed")
                
                if(error != nil) {
                    println(error.localizedDescription)
                } else {
                    
                    
                    var err: NSError?
                    
                    var results = NSJSONSerialization.JSONObjectWithData(data,
                        options: NSJSONReadingOptions.MutableContainers,
                    error: &err) as! NSDictionary
                    
                    if(err != nil) {
                        println("JSON Error \(err!.localizedDescription)")
                    }
                    
                    println("\(results.count) JSON rows returned and parsed into an array")
                    
                    if (results.count != 0) {
                        // For this example just spit out the first item "event" entry
                        //var rowData: NSDictionary = results[0] as! NSDictionary
                        self.User_Token = results["User_Token"] as! String;
                        println("Got \(self.User_Token) out")
                    } else {
                        println("No rows returned")
                    }
                }
        })
        
        task.resume()
    }
}