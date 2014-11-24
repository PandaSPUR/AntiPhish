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
    @IBOutlet var urlDecisionLabel: UILabel!
    @IBOutlet var scanOutputText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "responseReceiver", name: "responseReceived", object: nil)
        
        urlInputLabel.text = urlInput
        urlDecisionLabel.text = "Scanning Website..."
        
        expandURL(urlInput)
        googleScan(urlInput)
        vtScan(urlInput)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func responseReceiver() {
        self.updateUI()
    }
    
    func updateUI() {
        var longurlResult = resultContainer.longurl
        var googleResult = resultContainer.google
        var vtResult = resultContainer.vt
        
        //If all of the scans are done, write the decision
        if (longurlResult.responseCode != 0 && googleResult.responseCode != 0 && vtResult.responseCode != 0) {
            //If the site is malicious
            if (googleResult.responseCode != 204 || vtResult.positives != 0) {
                urlDecisionLabel.text = "Suspicious Website"
            }
            else {
                urlDecisionLabel.text = "Legitimate Website"
            }
        }
        
        //Build the text to go into the scan output box
        var scanOutput = "Scan results:"
        if (googleResult.responseCode == 204) {
            scanOutput = scanOutput + "\nGoogle determined this website is safe."
        }
        else if (googleResult.responseCode == 200) {
            scanOutput = scanOutput + "\nGoogle determined this website is unsafe."
        }
        if (vtResult.responseCode == 200) {
            if (vtResult.positives > 0) {
                scanOutput = scanOutput + "\nVirusTotal \(vtResult.positives) out of \(vtResult.total) scans determined this website is unsafe:"
                if (vtResult.phishing > 0) {
                    scanOutput = scanOutput + "\n - \(vtResult.phishing) scans determined this is a phishing website"
                }
                if (vtResult.malware > 0) {
                    scanOutput = scanOutput + "\n - \(vtResult.malware) scans determined this website contains malware"
                }
            }
            else {
                scanOutput = scanOutput + "\nVirusTotal scans determined this website is safe."
            }
        }
        scanOutputText.text = scanOutput
        scanOutputText.textColor = UIColor.whiteColor()
    }
    
}