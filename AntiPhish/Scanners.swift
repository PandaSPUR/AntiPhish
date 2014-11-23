//
//  Scanners.swift
//  AntiPhish
//
//  Created by Panda on 11/23/14.
//  Copyright (c) 2014 Panda. All rights reserved.
//

import Foundation
import Alamofire

func escapeURL(url: String) -> String{
    var customAllowedSet =  NSCharacterSet(charactersInString:"=\"#%/<>?@\\^`{|}:~").invertedSet
    var escapedURL = (url.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet))!
    return(escapedURL)
}

func googleScan(url: String) {
    var googleAPIKey = apiKeyContainer.sharedInstance.google
    var resultContainer = ScanResults.sharedInstance
    
    var escapedURL = escapeURL(url)
    var client = "com.hpchan.AntiPhish"
    var appVer = "1.0"
    var protocolVer = "3.1"
    var googleURL = "https://sb-ssl.google.com/safebrowsing/api/lookup?client=\(client)&key=\(googleAPIKey)&appver=\(appVer)&pver=\(protocolVer)&url=\(escapedURL)"
    
    Alamofire.request(.GET, googleURL)
        .responseString { (request, response, string, error) in
            println(response!.statusCode)
            println(string!)
    }
}