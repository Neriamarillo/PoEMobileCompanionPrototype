//
//  FirstViewController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 6/29/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import UIKit
import WebKit

class CurrencyViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webViewContainer: UIView!
    
    var webView: WKWebView!
    
    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = true
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let myUrl = URL(string: "https://poe.ninja/challenge/currency")
        let myRequest = URLRequest(url: myUrl!)
        webView.load(myRequest)
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

}

