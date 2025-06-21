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
    func showGeneralError(title: String, message: String, completion: @escaping (() -> Void), buttonTitle: String)
}

protocol BasePresenterProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func showGeneralError(title: String, message: String, completion: @escaping (() -> Void), buttonTitle: String)
}
