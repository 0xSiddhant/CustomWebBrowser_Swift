//
//  WBScriptHandler.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 21/06/25.
//

import Foundation
import WebKit

protocol WBScriptHandlerProtocol: WKScriptMessageHandler {
    var scriptName: String { get }
}

final class WBScriptMessageManager {
    
    var handlers: [WBScriptHandlerProtocol]
    
    init(handlers: WBScriptHandlerProtocol...) {
        self.handlers = handlers
    }
    
}
