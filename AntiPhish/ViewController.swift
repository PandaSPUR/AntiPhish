//
//  ViewController.swift
//  AntiPhish
//
//  Created by Panda on 11/12/14.
//  Copyright (c) 2014 Panda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        urlInput.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var urlInput: UISearchBar!
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.performSegueWithIdentifier("gotoScan", sender: self)
    }
}

