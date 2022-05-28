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
    
}
