//
//  NewTabPresenter.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 28/05/22.
//  Copyright (c) 2022. All rights reserved.
//

import UIKit

protocol NewTabPresenterProtocol: BaseViewProtocol {
    func presentSomething()
}

class NewTabPresenter: BasePresenter, NewTabPresenterProtocol {
    weak var view: NewTabViewProtocol?
    var interactor: NewTabInteractorProtocol?
    var router: NewTabRouterProtocol?

    init(viewController: NewTabViewProtocol,
                  interactor: NewTabInteractorProtocol,
                  router: NewTabRouterProtocol) {
        super.init()
        self.view = viewController
        self.interactor = interactor
        self.router = router
        self.baseView = viewController
    }

    
    func presentSomething() {
        //Transform Response Model to Displayed Model
        interactor?.startDoingSomething()
    }
    
    
    // MARK: - Transform Model-ViewModel


}

