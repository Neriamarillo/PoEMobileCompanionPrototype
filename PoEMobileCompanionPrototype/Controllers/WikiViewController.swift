//
//  FirstViewController.swift
//  PoEMobileCompanionPrototype
//
//  Created by Jorge Nieves on 6/29/20.
//  Copyright © 2020 Jorge Nieves. All rights reserved.
//

//MARK: - TODO
// Look into dislaying elements of the WebView (back, fwd, reader, etc).
// Look into using the search term for the Beasts and the Helmet Enchants in their respective overview page

import UIKit
import WebKit

class WikiViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    var webView = WKWebView()
    
    var searchItem: String!
    var searchItemType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        setupView()
        sendRequest()
    }
    
    func setupView() {
        
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        webViewContainer.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.widthAnchor.constraint(equalTo: webViewContainer.widthAnchor),
            webView.heightAnchor.constraint(equalTo: webViewContainer.heightAnchor)
        ])
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
    
    @IBAction func goBack() {
        webView.goBack()
    }
    
    @IBAction func goForward() {
        webView.goForward()
    }
    
    @IBAction func reload() {
        webView.reload()
    }
    
}