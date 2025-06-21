//
//  NewTabPresenter.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 28/05/22.
//  Copyright (c) 2022. All rights reserved.
//

import UIKit

protocol NewTabPresenterProtocol: BasePresenterProtocol {
    var scriptHandler: WBScriptMessageManager { get }
    
    func generateURL(with str: String)
    func openURL(with req: URLRequest)
    func backToHomePage()
}

class NewTabPresenter: BasePresenter, NewTabPresenterProtocol {
    weak var view: NewTabViewProtocol?
    var interactor: NewTabInteractorProtocol?
    var router: NewTabRouterProtocol?

    var scriptHandler: WBScriptMessageManager
    
    init(viewController: NewTabViewProtocol,
                  interactor: NewTabInteractorProtocol,
                  router: NewTabRouterProtocol) {
        
        scriptHandler = .init(
            handlers: FileDownloadHandler()
        )
        
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
        view?.resetWebPage()
        view?.showHideSearchView(false)
    }
    
    override func startLoading() {
        view?.startWebLoading()
    }
    
    override func stopLoading() {
        view?.stopWebLoading()
    }
    // MARK: - Transform Model-ViewModel


}

