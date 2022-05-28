//
//  NewTabInteractor.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 28/05/22.
//  Copyright (c) 2022. All rights reserved.
//

import UIKit

protocol NewTabInteractorProtocol {
    func generateURL(with str: String)
    
}

final class NewTabInteractor: BaseInteractor, NewTabInteractorProtocol {
    var presenter: NewTabPresenterProtocol?
        
    // MARK: - API calls
    
    func generateURL(with str: String) {
        if str.starts(with: "http") {
            generateURLRequest(urlStr: str)
        } else if str.starts(with: "www") {
            let finalStr = "https://\(str)"
            generateURLRequest(urlStr: finalStr)
        } else {
            let str = generateGoogleSearchURL(with: str)
            generateURL(with: str)
        }
    }
    
    private func generateGoogleSearchURL(with str: String) -> String {
        let urlStr = "\(URLConstants.googleSearch.rawValue)\(str)"
        if let str = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return str
        }
        return urlStr.replacingOccurrences(of: " ", with: URLStandard.replaceWhiteSpace.rawValue)
    }
    
    private func generateURLRequest(urlStr: String) {
        var urlReq: URLRequest
        defer {
            presenter?.openURL(with: urlReq)
        }
        guard let url = URL(string: urlStr.trim()) else {
            urlReq = URLRequest(url: URL(string: URLConstants.googleHomePage.rawValue)!)
            return
        }
        urlReq = URLRequest(url: url)
    }
    
    // MARK: - Business logic
    
    
}

