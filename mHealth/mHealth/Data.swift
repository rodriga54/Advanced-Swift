//
//  Data.swift
//  mHealth
//
//  Created by Abe Rodriguez on 4/9/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import Foundation
//  excercise array
//public var exy = [String: [String]]()
//public var exKey: [String] = []
//public var exName: [String] = []
//public var exCat: [String] = []
public var exKey = ""
public var exName = ""
public var exCat = ""
// Workout arrays
public var wkKey: [String] = []
public var wkLabel: [String] = []
public var wkInst: [String] = []

class Excercises: AnyObject
{
    var exKey = ""
    var exName = ""
    var exCat = ""
    init(exKey: String, exName: String, exCat: String)
    {
        self.exKey = exKey
        self.exName = exName
        self.exCat = exCat
    }
    
//    init(data: NSDictionary)
//    {
//        exKey = [data["pk"] as! String]
//        exName = [data["name"] as! String]
//        exCat = [data["category"] as! String]
//    }
}// End of Excercises class


class Workouts: AnyObject
{
    init(data: NSDictionary)
    {
        wkKey = [data["pk"] as! String]
        wkLabel = [data["label"] as! String]
        wkInst = [data["instructions"] as! String]
    }
}// End of Workouts class



class Dataloads
{
    /* ###########################################################################
     Function: PostAppUasge (fname: String, lname:String, url: URL, 
     ############################################################################*/
    func PostAppUasge (pin: String, url: URL, completion:@escaping (([Pin])-> Void))
    {
        let date = Date()
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let uploadData = "pin=\(pin) &dt=\(date)".data(using: String.Encoding.utf8)
        let task = URLSession.shared.uploadTask(with: request as URLRequest, from: uploadData) {
            (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode != 200 {
                // Perform some error handling, other status codes should be
                // handled as well
                print("HTTP Error: status code \(httpResponse!.statusCode)") } else if (data == nil && error != nil) {
                print("Error: No response data downloaded") } else {
                print("response data downloaded")
            }
        }
        task.resume()
    }// End of UpLoadPost
}// End of Dataloads class
