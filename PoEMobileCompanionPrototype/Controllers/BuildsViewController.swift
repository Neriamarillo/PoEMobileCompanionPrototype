//
//  SecondViewController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 6/29/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import UIKit
import WebKit

class BuildsViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = true
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        let myUrl = URL(string: "https://poe.ninja/challenge/builds?class=Trickster")
        let myUrl = URL(string: "https://poe.ninja/api/data/0cec9d33b00d14c0602a9a5a9165737c/getbuildoverview?overview=harvest&type=exp&language=en")
        let myRequest = URLRequest(url: myUrl!)
        webView.load(myRequest)
    }


}

