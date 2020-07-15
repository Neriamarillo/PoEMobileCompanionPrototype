//
//  ForumViewController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 6/30/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import UIKit
import WebKit

class ForumViewController: UIViewController, WKUIDelegate  {
    
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
        let myUrl = URL(string: "https://www.pathofexile.com/forum")!
        webView.load(URLRequest(url: myUrl))
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = "PoE Forum"
    }
    
}
