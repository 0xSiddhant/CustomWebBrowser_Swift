//
//  UtilMethods.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 29/05/22.
//
import WebKit

class UtilMethods {
    
    static func takeSnapshot(of webView: WKWebView, completion: @escaping ((UIImage) -> Void)) {
        
        let config = WKSnapshotConfiguration()
        config.rect = CGRect(x: 0, y: 0, width: 150, height: 50)
        
        // If you don’t want a cropped image - i.e. you want the whole thing – just use nil instead of config.
        webView.takeSnapshot(with: config) { image, error in
            if let image = image {
                //TODO: - Need to add share image functionality
                print(image.size)
                completion(image)
            }
        }
    }
}
