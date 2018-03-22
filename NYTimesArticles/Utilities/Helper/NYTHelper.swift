//
//  NYTHelper.swift
//  NYTimesArticles
//
//  Created by Soumen Das on 21/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import UIKit

class NYTHelper: NSObject {
    static let helper = NYTHelper()
    private override init() {}
    
    // variable declaration
    private var loaderView: UIView?
    private var clearView: UIView?
    
    func showLoader() {
        if loaderView == nil {
            loaderView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            loaderView?.layer.cornerRadius = 4.0
            loaderView?.backgroundColor = UIColorRGBA(red: 0, green: 0, blue: 0, alpha: 0.8)
            loaderView?.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator.color = .white
            activityIndicator.center = CGPoint(x: loaderView!.bounds.width / 2, y: loaderView!.bounds.height / 2)
            loaderView!.addSubview(activityIndicator)
            UIApplication.shared.windows.first!.addSubview(loaderView!)
            activityIndicator.startAnimating()
        }
    }
    
    func hideLoader() {
        if loaderView != nil {
            loaderView!.removeFromSuperview()
            loaderView = nil
        }
    }
    
    /**
    ClearView simply opens a UIView at top of the screen if user want's to diable the user interaction for any situation, specially during the API Call.
    */
    func showClearView() {
        if clearView == nil {
            clearView = UIView(frame: UIScreen.main.bounds)
            clearView?.backgroundColor = .clear
            UIApplication.shared.windows.first!.addSubview(clearView!)
        }
    }
    
    func hideClearView() {
        if clearView != nil {
            clearView!.removeFromSuperview()
            clearView = nil
        }
    }
}
