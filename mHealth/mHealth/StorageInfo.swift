//
//  StorageInfo.swift
//  mHealth
//
//  Created by Abe Rodriguez on 4/9/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import Foundation

public var pin: String = ""
public var version: String = ""

class Pin: AnyObject
{
    init(data: NSDictionary)
    {
        pin = data["pin"] as! String
        version = data["verison"] as! String
    }
}// End of Pin class


class Exercise2: AnyObject
{
    var pin: String
    
    init(data: NSDictionary)
    {
        self.pin = data["pin"] as! String
    }
}// End of Exercise class

class Workout2: AnyObject
{
    var pin: String
    
    init(data: NSDictionary)
    {
        self.pin = data["pin"] as! String
    }
}// End of Workout class
