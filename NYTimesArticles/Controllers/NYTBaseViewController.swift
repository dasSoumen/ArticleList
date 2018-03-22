//
//  NYTBaseViewController.swift
//  NYTimesArticles
//
//  Created by Soumen Das on 21/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import UIKit

/**
 All ViewControllers should be inherited from this ViewController. So that in case of any changes required in all the ViewControllers only changes in this base class will solve the purpose.
 */
class NYTBaseViewController: UIViewController {

    // MARK: - IBOutlets
    /**
     The IBInspectable property allows us to show and hide the "menu" icon from the storyboard.
     */
    @IBInspectable var menuEnabled: Bool = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if menuEnabled {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "HeaderMenuIcon"), style: .plain, target: self, action: #selector(openMenu))
        }
    }
    
    // MARK: - Button Actions
    @objc private func openMenu() {
        debugPrint("Menu Button Tapped")
    }
}
