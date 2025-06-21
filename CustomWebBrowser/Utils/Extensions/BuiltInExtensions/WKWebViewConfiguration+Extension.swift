//
//  WKWebViewConfiguration+Extension.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 21/06/25.
//

import Foundation
import WebKit

extension WKWebViewConfiguration {
    
    func addScriptMessageHandler(_ manager: WBScriptMessageManager) {
        
        for handler in manager.handlers {
            userContentController.add(handler, name: handler.scriptName)
        }
//        userContentController.add(self, name: "downloadFileOnDevice")
//        userContentController.add(self, name: "subscribeToTopics")
//        userContentController.add(self, name: "updateCustomerToken")
//        userContentController.add(self, name: "uploadFileData")
        
    }
}
