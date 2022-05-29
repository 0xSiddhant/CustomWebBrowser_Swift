//
//  CustomTransition.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 29/05/22.
//

import UIKit

class CustomTransition {
    
    static func showHide(_ view: UIView, status: Bool) {
        UIView.transition(
            with: view,
            duration: 0.33,
            options: [.curveEaseOut, .showHideTransitionViews],
            animations: {
                view.isHidden = status
            },
            completion: nil)
    }
}
