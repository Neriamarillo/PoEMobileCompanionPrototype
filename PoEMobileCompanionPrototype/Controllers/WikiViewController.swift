//
//  FirstViewController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 6/29/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

//MARK: - TODO
// Look into using the search term for the Beasts and the Helmet Enchants in their respective overview page

import UIKit
import WebKit

class WikiViewController: UIViewController, WKNavigationDelegate, UIToolbarDelegate {
    
    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var toolbarBackButton: UIBarButtonItem!
    @IBOutlet weak var toolbarForwardButton: UIBarButtonItem!
    @IBOutlet weak var toolbarRefreshButton: UIBarButtonItem!
    
    var webView = WKWebView()
    
    var searchItem: String!
    var searchItemType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.isToolbarHidden = false
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        setupView()
        sendRequest()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupView() {
        adjustLargeTitleSize()
        webView.navigationDelegate = self
        webViewContainer.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        
        NSLayoutConstraint.activate([
            webView.widthAnchor.constraint(equalTo: webViewContainer.widthAnchor),
            webView.heightAnchor.constraint(equalTo: webViewContainer.heightAnchor)
        ])
        navigationItem.title = "Official PoE Wiki"
        setupToolbar()
    }
    
    func setupToolbar() {
        toolbarBackButton.action = #selector(webView.goBack)
        toolbarForwardButton.action = #selector(webView.goForward)
        toolbarRefreshButton.action = #selector(webView.reload)
    }
    
    func sendRequest() {
        let myUrl = setupUrl(searchString: searchItem)
        let myRequest = URLRequest(url: myUrl)
        webView.load(myRequest)
    }
    
    func setupUrl(searchString: String) -> URL {
        let formattedSearchItem = searchItem.replacingOccurrences(of: " ", with: "_")
        let itemToSearch: String = { () -> String in
            switch self.searchItemType {
                //                case "HelmetEnchant":
                //                    return "Labyrinth_Enchant"
                //                case "Beast":
                //                    return "Bestiary"
                default:
                    return formattedSearchItem
            }
        }()
        
        let myUrl = URL(string: "https://pathofexile.gamepedia.com/\(itemToSearch)")!
        return myUrl
    }
    
    //MARK: - WebView Navigation Methods
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        var scriptContent = "var meta = document.createElement('meta');"
        scriptContent += "meta.name='viewport';"
        scriptContent += "meta.content='width=device-width';"
        scriptContent += "document.getElementsByTagName('head')[0].appendChild(meta);"
        self.webView.evaluateJavaScript(scriptContent, completionHandler: nil)
        
        if self.webView.backForwardList.backItem != nil {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        } else {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
}
