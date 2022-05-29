//
//  BaseView.swift
//  TestViper
//
//  Created by Ankit Sabharwal on 09/02/22.
//

import Foundation

public protocol BaseView: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func showError(message: String)
    func showGeneralError(title: String, message: String, completion: @escaping (() -> Void), buttonTitle: String)
    func resetWebPage()
}

protocol BaseViewProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func showGeneralError(action: @escaping () -> Void)
    func resetWebPage()
}
