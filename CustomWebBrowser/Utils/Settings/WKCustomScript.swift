//
//  WKCustomScript.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 29/05/22.
//

import Foundation
import WebKit

enum WKCustomScript {
    /// This method disable Copy Paste Selection of text from the webpage
    /// - Returns: WKUserScript
    static func copyPasteSelectionDisableScript() -> WKUserScript {
        let css = "* { -webkit-touch-callout: none; -webkit-user-select: none;}"
        let source = "var style = document.createElement('style'); style.innerHTML = '\(css)'; document.head.appendChild(style);"
        
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: true)
        return userScript
    }
    
    static func disableZoomScript() -> WKUserScript {
        let source = "document.documentElement.style.setProperty('zoom', '100%', 'important');"
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: true)
        return userScript
    }
    
    static func disableSelectionScript() -> WKUserScript {
        let source = "document.oncontextmenu = function() { return false; }"
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: true)
        return userScript
    }
    
    static func disableScrollingScript() -> WKUserScript {
        let source = "document.body.style.overflowY = 'hidden';"
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: true)
        return userScript
    }
    
    static func disableCursorScript() -> WKUserScript {
        let source = "document.body.style.cursor = 'default';"
        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: true)
        return userScript
    }
    
   static func setMobileScreenViewPortScript() -> WKUserScript {
        let source = "var metaTag = document.createElement('meta'); metaTag.name = 'viewport'; metaTag.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'; document.getElementsByTagName('head')[0].appendChild(metaTag);"
       let userScript = WKUserScript(source: source,
                                     injectionTime: .atDocumentEnd,
                                     forMainFrameOnly: true)
       return userScript
    }
}
