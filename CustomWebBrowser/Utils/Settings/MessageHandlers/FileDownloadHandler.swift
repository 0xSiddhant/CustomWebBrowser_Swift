//
//  FileDownloadHandler.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 21/06/25.
//

import Foundation
import WebKit

final class FileDownloadHandler: NSObject, WBScriptHandlerProtocol {
    var scriptName: String
    
    override init() {
        scriptName = "FileDownloadHandler"
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("------- \(message.name) --------- ", #function, #file)
    }
}
