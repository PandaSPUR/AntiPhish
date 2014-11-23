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
    
}

struct vtResult {
    //let jsonObj: JSON?
}