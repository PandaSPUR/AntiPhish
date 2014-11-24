//
//  ScanResults.swift
//  AntiPhish
//
//  Created by Panda on 11/22/14.
//  Copyright (c) 2014 Panda. All rights reserved.
//

import Foundation
import SwiftyJSON

private let _ScanResultsSharedInstance = ScanResults()

class ScanResults {
    var longurl = longurlResult()
    var google = googleResult()
    var vt = virustotalResult()
    
    class var sharedInstance : ScanResults {
        return _ScanResultsSharedInstance
    }
    
    func reset() {
        longurl = longurlResult()
        google = googleResult()
        vt = virustotalResult()
    }
}

struct longurlResult {
    var responseCode = 0 //200 is good, otherwise just use the full URL.
    var url = ""
}

struct googleResult {
    var responseCode = 0 //200 (bad site, check response), 204 (good), else (error)
    var responseCodeString = ""
    var responseBody = "" //"phishing" "malware" or "phishing,malware"
}

struct virustotalResult {
    var responseCode = 0
    var jsonObj = JSON("") //store the whole thing, just in case
    var positives = 0 //"positives" = how many scanners had a hit.
    var total = 0 //total scanners
    
    //Experimental
    //Iterate through all scan results and count amount of "malware site" and "phishing site"
    var malware = 0
    var phishing = 0
    
}

struct metascanResult {
    
}