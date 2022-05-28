//
//  NewTabRouter.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 28/05/22.
//  Copyright (c) 2022. All rights reserved.
//

import UIKit

protocol NewTabRouterProtocol {
    func navigateToViewController()
}

final class NewTabRouter: NewTabRouterProtocol {
    weak var viewController: NewTabViewController?
    
    // MARK: - Setup module connections
    
    static func createModule() -> NewTabViewController? {
        let storyboard = UIStoryboard(name: "NewTabStoryboard", bundle:nil )
        if let controller = storyboard.instantiateInitialViewController() as? NewTabViewController {
            let router = NewTabRouter()
            router.viewController = controller
            
            let interactor = NewTabInteractor()
            let presenter = NewTabPresenter(
                viewController: controller,
                interactor: interactor,
                router: router)
            
            interactor.presenter = presenter
            controller.presenter = presenter
            return controller
        }
        return nil
    }
    
    // MARK: - Navigation
    
    func navigateToViewController() {
        // TODO: Navigate to viewController
    }
}
