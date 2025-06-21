//
//  BasePresenter.swift
//  Testing
//
//  Created by Ankit Sabharwal on 10/02/22.
//

import UIKit

class BasePresenter: BasePresenterProtocol {
    
    weak var baseView: BaseView?
    
    func startLoading() {
        baseView?.startLoading()
    }
    
    func stopLoading() {
        baseView?.stopLoading()
    }
    
    func showGeneralError(title: String, message: String, completion: @escaping () -> Void, buttonTitle: String) {
        baseView?.showGeneralError(title: title, message: message, completion: completion, buttonTitle: buttonTitle)
    }
}
