//
//  ScanViewController.swift
//  AntiPhish
//
//  Created by Panda on 11/23/14.
//  Copyright (c) 2014 Panda. All rights reserved.
//

import Foundation

import UIKit

class ScanViewController: UIViewController, UISearchBarDelegate {
    var urlInput = ""
    var resultContainer = ScanResults.sharedInstance
    
    @IBOutlet var urlInputLabel: UILabel!
    @IBOutlet var scanOutput: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlInputLabel.text = urlInput
        
        expandURL(urlInput)
        googleScan(urlInput)
        vtScan(urlInput)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        var longurlResult = resultContainer.longurl
        var googleResult = resultContainer.google
        var vtResult = resultContainer.vt
        
        //If all of the scans are done
        if (longurlResult.responseCode != 0 && googleResult.responseCode != 0 && vtResult.responseCode != 0) {
            //If the site is malicious
            if (googleResult.responseCode != 204 || vtResult.positives != 0) {
                
            }
        }
    }
}