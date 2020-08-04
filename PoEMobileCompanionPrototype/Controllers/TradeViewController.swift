//
//  TradeViewController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 6/30/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

import UIKit
import WebKit

class TradeViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    var leagueName: String = "Harvest"
    var searchUrl: URL!
    var tradeManager = TradeManager()
    var wantItem = String()
    var haveItem = String()
    
    override func loadView() {
        
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = true
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tradeManager.delegate = self
        print("Want item: \(wantItem), Have item: \(haveItem)")
        tradeManager.createUrl(wantItem: wantItem, haveItem: haveItem, status: "online")
        /*TODO: Implement the creation of url for items now that it is working for currency type searches. */
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        var scriptContent = "var meta = document.createElement('meta');"
        scriptContent += "meta.name='viewport';"
        scriptContent += "meta.content='width=device-width';"
        scriptContent += "document.getElementsByTagName('head')[0].appendChild(meta);"
        self.webView.evaluateJavaScript(scriptContent, completionHandler: nil)
    }
    
}
//MARK: - Trade Manager Delegate
extension TradeViewController: TradeManagerDelegate {
    func didFetchTradeSearch(_ tradeManager: TradeManager, tradeUrl: URL) {
        self.searchUrl = tradeUrl
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: self.searchUrl!))
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
