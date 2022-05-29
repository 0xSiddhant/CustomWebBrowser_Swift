//
//  NewTabViewController.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 28/05/22.
//  Copyright (c) 2022. All rights reserved.
//

import UIKit
import WebKit

protocol NewTabViewProtocol: BaseView {
    func openURL(with req: URLRequest)
}

class NewTabViewController: BaseViewController {
    var presenter: NewTabPresenterProtocol?

    //MARK: - Outlets
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var searchView: BaseSearchBar!
//    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var addNewTabBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet var btnCollections: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    deinit {
        webView.removeObserver(self, forKeyPath: "title")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward))
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.searchText = { [weak self] str in
            self?.presenter?.generateURL(with: str)
        }
        
        contentStackView.addArrangedSubview(webView)
        
        // For handling webview UI Activity
        webView.uiDelegate = self
        
        // For handling webview activity
        webView.navigationDelegate = self
        
        //  Monitoring page loads
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        //  Reading a web page’s title as it changes
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)

        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
        initView()
    }
    
    private func initView() {
        for btn in btnCollections {
            btn.setTitle("", for: .normal)
            btn.tintColor = .primaryColor
        }
        
        backBtn.isEnabled = false
        nextBtn.isEnabled = false
    }
    
    // MARK:  Monitoring Website Activity
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            print(Float(webView.estimatedProgress))
        } else if keyPath == "title" {
            if let title = webView.title {
                setNavTitle(title)
            }
        } else if keyPath == "canGoBack" {
            backBtn.isEnabled = webView.canGoBack
        } else if keyPath == "canGoForward" {
            nextBtn.isEnabled = webView.canGoForward
        }
    }
    
    //MARK: - IBActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        webView.goBack()
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        webView.goForward()
    }
    
    @IBAction func addNewTabBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func homeBtnAction(_ sender: UIButton) {
        //TODO: - Need to add clear cookies
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if cookie.name == "authentication" {
                    self.webView.configuration.websiteDataStore.httpCookieStore.delete(cookie)
                } else {
                    print("\(cookie.name) is set to \(cookie.value)")
                }
            }
        }
    }
    
    @IBAction func moreBtnAction(_ sender: UIButton) {
        
        let config = WKSnapshotConfiguration()
        config.rect = CGRect(x: 0, y: 0, width: 150, height: 50)
        
        // If you don’t want a cropped image - i.e. you want the whole thing – just use nil instead of config.
        webView.takeSnapshot(with: config) { image, error in
            if let image = image {
                //TODO: - Need to add share image functionality
                print(image.size)
            }
        }
    }
}

// MARK: - NewTabViewController
extension NewTabViewController: NewTabViewProtocol {
    func openURL(with req: URLRequest) {
        searchView.isHidden = true
        webView.load(req)
    }
}

//MARK: - Webkit Navigation Delegate
extension NewTabViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        progressView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url,
           let host = url.host {
            if host == "www.apple.com" {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.printURLContent()
        stopLoading()
        //TODO: - Use this for creating History Page
        for page in webView.backForwardList.backList {
            print("User visited")
            print("\tTitle: \(page.title)\nOriginated From: \(page.initialURL)")
            print("\tFull Path: \(page.url.absoluteString)")
            print("-----------------")
        }
        
        
        //TODO: - For Disabling Text Selection and keyboard event in Webpage
//        webView.evaluateJavaScript(WKCustomScript.copyPasteSelectionDisableScript().source) { (result, error) in
//            if let result = result {
//                print(result)
//            }
//        }
//
//        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
           print(error.localizedDescription)
    }
}

//MARK: - Webkit UI Delegate
extension NewTabViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let ac = UIAlertController(title: "Hey, listen!", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
        completionHandler()
    }
    
}
