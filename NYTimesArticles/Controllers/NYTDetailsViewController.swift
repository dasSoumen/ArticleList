//
//  NYTDetailsViewController.swift
//  NYTimesArticles
//
//  Created by Timir Baran Kundu on 22/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import UIKit
import WebKit

class NYTDetailsViewController: NYTBaseViewController, WKNavigationDelegate {

    // MARK: - IBOutlets
    @IBOutlet private weak var newsWebView: WKWebView!
    var newsURL: URL?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsWebView.navigationDelegate = self
        if newsURL != nil {
            let request = URLRequest(url: newsURL!)
            newsWebView.load(request)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop the request while user pop back.
        newsWebView.stopLoading()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: - WKWebView Delegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
