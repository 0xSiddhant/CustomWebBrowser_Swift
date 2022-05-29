//
//  NewTabPresenter.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 28/05/22.
//  Copyright (c) 2022. All rights reserved.
//

import UIKit

protocol NewTabPresenterProtocol: BaseViewProtocol {
    func generateURL(with str: String)
    func openURL(with req: URLRequest)
    func backToHomePage()
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

    func generateURL(with str: String) {
        interactor?.generateURL(with: str)
    }
    
    func openURL(with req: URLRequest) {
        view?.showHideSearchView(true)
        view?.openURL(with: req)
    }
    
    func backToHomePage() {
        resetWebPage()
        view?.showHideSearchView(false)
    }
    // MARK: - Transform Model-ViewModel


}

