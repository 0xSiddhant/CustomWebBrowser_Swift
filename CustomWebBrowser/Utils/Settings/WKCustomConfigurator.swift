//
//  WKWebKitCustomConfigurator.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 29/05/22.
//

import WebKit

class WKCustomConfigurator {
    
    static func create() -> WKWebViewConfiguration {
        
        let config = WKWebViewConfiguration()
        config.dataDetectorTypes = [.all]
        
        // allow to play video inside your browser
        config.allowsInlineMediaPlayback = true
        config.allowsPictureInPictureMediaPlayback = true
        
        
        // For integrating JS in all loaded web page
        config.userContentController = getContentController()
        
        return config
    }
    
    static private func getContentController() -> WKUserContentController {

        let userContentController = WKUserContentController()
        userContentController.addUserScript(WKCustomScript.copyPasteSelectionDisableScript())
        
        return userContentController
    }
    
    static func clearCookies(webView: WKWebView) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
//                if cookie.name == "authentication" {
//                    webView.configuration.websiteDataStore.httpCookieStore.delete(cookie)
//                } else {
//                    print("\(cookie.name) is set to \(cookie.value)")
//                }
                webView.configuration.websiteDataStore.httpCookieStore.delete(cookie)
            }
        }

    }
    
}
