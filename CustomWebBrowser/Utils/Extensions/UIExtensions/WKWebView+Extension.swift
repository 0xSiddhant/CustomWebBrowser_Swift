//
//  WKWebView+Extension.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 28/05/22.
//

import Foundation
import WebKit

extension WKWebView {
    
    func printURLContent() {
        print(self.url?.scheme)
        print(self.url.publisher)
        print(self.url?.host)
        print(self.url?.port)
        print(self.url?.path)
        print(self.url?.baseURL)
        print(self.url?.absoluteString)
        print(self.url?.query)
    }
}
