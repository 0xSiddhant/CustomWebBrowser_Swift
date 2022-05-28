//
//  BaseNavigationController.swift
//  TestViper
//
//  Created by Ankit Sabharwal on 09/02/22.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
//    let barColor = UIColor(red: 252/255.0, green: 138/255.0, blue: 21/255.0, alpha: 1)
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .secondaryColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                 .font: UIFont.boldSystemFont(ofSize: 17)]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
                                                      .font: UIFont.boldSystemFont(ofSize: 17)]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        self.navigationBar.tintColor = UIColor.white
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
