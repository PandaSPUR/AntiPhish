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

func expandURL(url: String) {
    var resultContainer = ScanResults.sharedInstance
    var longURL = "http://api.longurl.org/v2/expand?format=json&url=\(url)"
    
    Alamofire.request(.GET, longURL)
        .responseJSON{ (request, response, string, error) in
            resultContainer.longurl.responseCode = response!.statusCode
            if response!.statusCode == 200 {
                resultContainer.longurl.url = string!["long-url"] as NSString
            }
    }
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
            resultContainer.google.responseCode = response!.statusCode
            resultContainer.google.responseBody = string!
    }
}

func vtScan(url: String) {
    var vtAPIKey = apiKeyContainer.sharedInstance.virustotal
    var resultContainer = ScanResults.sharedInstance
    
    var vtParameters = ["resource": url, "apikey": vtAPIKey]
    var vtURL = "https://www.virustotal.com/vtapi/v2/url/report"
    Alamofire.request(.POST, vtURL, parameters: vtParameters)
        .responseJSON { (request, response, string, error) in
            resultContainer.vt.responseCode = response!.statusCode
            
            let jsonObj = JSON(string!)
            resultContainer.vt.jsonObj = jsonObj
            resultContainer.vt.total = jsonObj["total"].intValue
            resultContainer.vt.positives = jsonObj["positives"].intValue
            
            var phishingCount = 0
            var malwareCount = 0
            for (key: String, subJson: JSON) in jsonObj["scans"] {
                if subJson["result"] == "malware site" {
                    malwareCount += 1
                }
                else if subJson["result"] == "phishing site" {
                    phishingCount += 1
                }
            }
            
            resultContainer.vt.phishing = phishingCount
            resultContainer.vt.malware = malwareCount
    }
}