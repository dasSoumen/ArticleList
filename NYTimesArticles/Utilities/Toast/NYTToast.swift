//
//  NYTToast.swift
//  NYTimesArticles
//
//  Created by Soumen Das on 21/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import UIKit
enum ToastPosition: Int {
    case top
    case middle
    case bottom
}

class NYTToast: UIView {
    @IBOutlet weak var labelToast: UILabel!
    @IBOutlet private weak var contentView: UIView!
    private var toastTitle: String!
    
    // MARK: - Button Actions
    @IBAction private func buttonCrossTapped(_ sender: Any) {
        let window = UIApplication.shared.windows.first
        if let toastView  = window?.viewWithTag(999) as? NYTToast {
            UIView.animate(withDuration: 0.2, animations: {
                toastView.alpha = 0.0
            }) { (_) in
                toastView.removeFromSuperview()
            }
        }
    }
    
    class func show(withText text: String, position: ToastPosition, withduration: Double? = 3.0) {
        let window = UIApplication.shared.windows.first
        let toastView = Bundle.main.loadNibNamed(NYTToast.name, owner: self, options: nil)?.first as! NYTToast
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.labelToast.text = text
        toastView.layoutIfNeeded()
        toastView.tag = 999
        toastView.alpha = 0.0
        window?.addSubview(toastView)
        UIView.animate(withDuration: 0.2, animations: {
            toastView.alpha = 1.0
        }) { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + withduration!) {
                UIView.animate(withDuration: 0.2, animations: {
                    toastView.alpha = 0.0
                }) { (_) in
                    toastView.removeFromSuperview()
                }
            }
        }
        
        switch position {
        case .top:
            let centerXContraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window!, attribute: .centerX, multiplier: 1.0, constant: 0)
            let topYConstraint = NSLayoutConstraint(item: toastView, attribute: .top, relatedBy: .equal, toItem: window!, attribute: .top, multiplier: 1.0, constant: 40)
            let leadingContraint = NSLayoutConstraint(item: toastView, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: window!, attribute: .left, multiplier: 1.0, constant: 10)
            let trailingContraint = NSLayoutConstraint(item: window!, attribute: .right, relatedBy: .greaterThanOrEqual, toItem: toastView, attribute: .right, multiplier: 1.0, constant: 10)
            window?.addConstraint(centerXContraint)
            window?.addConstraint(topYConstraint)
            window?.addConstraint(leadingContraint)
            window?.addConstraint(trailingContraint)
        case .middle:
            let centerXContraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window!, attribute: .centerX, multiplier: 1.0, constant: 0)
            centerXContraint.priority = UILayoutPriority(rawValue: 970)
            let centerYConstraint = NSLayoutConstraint(item: toastView, attribute: .centerY, relatedBy: .equal, toItem: window!, attribute: .centerY, multiplier: 1.0, constant: 0)
            let leadingContraint = NSLayoutConstraint(item: toastView, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: window!, attribute: .left, multiplier: 1.0, constant: 10)
            let trailingContraint = NSLayoutConstraint(item: toastView, attribute: .right, relatedBy: .greaterThanOrEqual, toItem: window!, attribute: .right, multiplier: 1.0, constant: 10)
            window?.addConstraint(centerXContraint)
            window?.addConstraint(centerYConstraint)
            window?.addConstraint(leadingContraint)
            window?.addConstraint(trailingContraint)
        case .bottom:
            let centerXContraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window!, attribute: .centerX, multiplier: 1.0, constant: 0)
            centerXContraint.priority = UILayoutPriority(rawValue: 970)
            let bottomYConstraint = NSLayoutConstraint(item: toastView, attribute: .bottom, relatedBy: .equal, toItem: window!, attribute: .centerY, multiplier: 1.0, constant: 0)
            let leadingContraint = NSLayoutConstraint(item: toastView, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: window!, attribute: .bottom, multiplier: 1.0, constant: 40)
            let trailingContraint = NSLayoutConstraint(item: toastView, attribute: .right, relatedBy: .greaterThanOrEqual, toItem: window!, attribute: .right, multiplier: 1.0, constant: 10)
            window?.addConstraint(centerXContraint)
            window?.addConstraint(bottomYConstraint)
            window?.addConstraint(leadingContraint)
            window?.addConstraint(trailingContraint)
        }
    }
}
