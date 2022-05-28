//
//  SplashViewController.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 28/05/22.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        
        if let vc = NewTabRouter.createModule() {
           keyWindow?.rootViewController = BaseNavigationController(rootViewController: vc)
        }
    }

}
