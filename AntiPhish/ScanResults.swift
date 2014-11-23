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
    class var sharedInstance : ScanResults {
        return _ScanResultsSharedInstance
    }
}

struct googleResult {
    var responseCode: Int //200 (bad site, check response), 204 (good), else (error)
    var responseCodeString: String
    var responseBody: String //"phishing" "malware" or "phishing,malware"
}

struct virustotalResult {
    var jsonObj: JSON //store the whole thing, just in case
    var positives: Int //"positives" = how many scanners had a hit.
    var total: Int //total scanners
    
}

struct metascanResult {
    
}