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
    
    //TODO: Add variables to be passed from the ItemDetails to here for the search items. Will use placeholder items in the createUrl method until that is implemented.
    
    override func loadView() {
        
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = true
        webView.allowsBackForwardNavigationGestures = true
        //        webView.sizeToFit()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.contentMode = .scaleAspectFill
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tradeManager.delegate = self
        tradeManager.createUrl(wantItem: "mirror", haveItem: "exalted", status: "online")
        //tradeManager.createUrl(wantItem: "Awakened Chain Support", haveItem: "", status: "online")
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
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
