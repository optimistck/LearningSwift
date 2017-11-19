//
//  DetailViewController.swift
//  Blog Reader
//
//  Created by Constantin on 12/22/16.
//  Copyright © 2016 Constantin. All rights reserved.

//  ec2-35-161-207-94.us-west-2.compute.amazonaws.com
//Instance state
//running
//Public IP
//35.161.207.94


//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var webView: UIWebView!

    func configureView() {
        // Update the user interface for the detail item.
        
        //self.title = detail.value(forKey: "title") as! String
        
        if let detail = self.detailItem {
            if let blogWebView = self.webView {
                //label.text = detail.value(forKey: "title") as! String
                blogWebView.loadHTMLString(detail.value(forKey: "content") as! String, baseURL: nil)
            }
        }
        


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Event? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

