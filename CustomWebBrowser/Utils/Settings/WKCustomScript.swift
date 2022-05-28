//
//  WKCustomScript.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 29/05/22.
//

import Foundation
import WebKit

class WKCustomScript {
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
}
