//
//  BasePresenter.swift
//  Testing
//
//  Created by Ankit Sabharwal on 10/02/22.
//

import UIKit

class BasePresenter: BaseViewProtocol {
    weak var baseView: BaseView?
    
    func startLoading() {
        self.baseView?.startLoading()
    }
    
    func stopLoading() {
        self.baseView?.stopLoading()
    }
    
    func showGeneralError(action: @escaping () -> Void) {
        
    }
    
    func resetWebPage() {
        baseView?.resetWebPage()
    }
}
