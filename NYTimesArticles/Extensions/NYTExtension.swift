//
//  NYTExtension.swift
//  NYTimesArticles
//
//  Created by Soumen Das on 21/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    public static var name: String {
        return String(describing: self.self)
    }
    public var name: String {
        return String(describing: self.self)
    }
}

extension UIFont {
    static func helveticaNeue(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    static func helveticaNeueMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
}

extension UITableView {
    
    func showNodataLabelWithText(_ text: String!) {
        hideNoDataLabel()
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 40)
        label.text = text.count > 0 ? text : "No data found"
        label.textColor = UIColorRGB(red: 121, green: 121, blue: 121)
        label.tag = 111
        label.font = UIFont.helveticaNeue(size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        label.center = CGPoint(x: self.frame.width/2.0, y: self.frame.height/2.0)
        self.addSubview(label)
    }
    
    func hideNoDataLabel() {
        for _views in self.subviews as [UIView] {
            if let labelView = _views as? UILabel {
                if labelView.tag == 111 {
                    labelView.isHidden = true
                    labelView.removeFromSuperview()
                    break
                }
            }
        }
    }
}
