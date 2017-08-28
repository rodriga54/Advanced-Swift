//
//  Data.swift
//  PetStore
//
//  Created by Abe Rodriguez on 3/7/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//
import UIKit
import Foundation


class PetDatabase: UITableViewCell  {

    //var mTableView = MasterViewController()

    //------------------------------------------------------------------------------
    //
    //
    //------------------------------------------------------------------------------

    func UpLoadPost ()
    {
        //(<#parameters#>) -> <#return type#> {
        //
        
        
        if let url = URL(string: "http://www.jorjabrown.us/petstore/api/owners/add") {
           // let session = URLSession.shared.uploadTask(with: <#T##URLRequest#>, fromFile: URL)
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
            let uploadData = "fname=Billy&lname=Bob".data(using: String.Encoding.utf8)
            let task = URLSession.shared.uploadTask(with: request as URLRequest, from: uploadData) {
                (data, response, error) in
                let httpResponse = response as? HTTPURLResponse
                if httpResponse!.statusCode != 200 {
                    // Perform some error handling, other status codes should be
                    // handled as well
                    print("HTTP Error: status code \(httpResponse!.statusCode)") } else if (data == nil && error != nil) {
                    print("Error: No response data downloaded") } else {
                    print("response data downloaded")
                    let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
                    print(dataString) }
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
    }// End of UpLoadPost
    
    
    
}//  End of Database class
