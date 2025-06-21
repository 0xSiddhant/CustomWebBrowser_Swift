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
    func startWebLoading()
    func stopWebLoading()
    func resetWebPage()
    
    func openURL(with req: URLRequest)
    func showHideSearchView(_ isHidden: Bool)
}

class NewTabViewController: BaseViewController {
    var presenter: NewTabPresenterProtocol?
    
    //MARK: - Outlets
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var searchView: BaseSearchBar!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var addNewTabBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet var btnCollections: [UIButton]!
    
    lazy var webView: WKWebView = {
        let configuraton = WKCustomConfigurator.create()
        if let presenter {
            configuraton.addScriptMessageHandler(presenter.scriptHandler)            
        }
        let webView = WKWebView(frame: .zero, configuration: configuraton)
        webView.scrollView.refreshControl = UIRefreshControl()
        webView.scrollView.refreshControl?.addTarget(self, action: #selector(startWebLoading), for: .valueChanged)
        return webView
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.title))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward))
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        setUpWebkit()
        
        setNavTitle("Home Page", textAlignment: .center)
    }
    
    private func setUpWebkit() {
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
    }
    
    private func initView() {
        for btn in btnCollections {
            btn.setTitle("", for: .normal)
            btn.tintColor = .primaryColor
        }
        
        backBtn.isEnabled = false
        nextBtn.isEnabled = false
        
        updateProgessBar(value: 0.0)
        
        searchView.searchText = { [weak self] str in
            self?.presenter?.generateURL(with: str)
        }
    }
    
    // MARK:  Monitoring Website Activity
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            updateProgessBar(value: Float(webView.estimatedProgress))
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
        presenter?.backToHomePage()
    }
    
    @IBAction func moreBtnAction(_ sender: UIButton) {
        
    }
    
    func updateProgessBar(value: Float) {
        if value == 1.0 {
            progressBar.isHidden = true
            progressBar.setProgress(0.0, animated: false)
        } else {
            progressBar.isHidden = value == 0.0
            progressBar.setProgress(value, animated: true)
        }
    }
}

// MARK: - NewTabViewController
extension NewTabViewController: NewTabViewProtocol {
    @objc
    func startWebLoading() {
        webView.reload()
    }
    
    func stopWebLoading() {
        webView.scrollView.refreshControl?.endRefreshing()
    }
    
    func resetWebPage() {
        webView.load(URLRequest(url: URL(string: URLConstants.blankPage.rawValue)!))
        setNavTitle("Home Page", textAlignment: .center)
    }
    
    func openURL(with req: URLRequest) {
        webView.load(req)
    }
    
    func showHideSearchView(_ isHidden: Bool) {
        searchView.textField.text = ""
        CustomTransition.showHide(searchView, status: isHidden)
    }
}

//MARK: - Webkit Navigation Delegate
extension NewTabViewController: WKNavigationDelegate {
    
    // Method called before loading url
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
//        if let url = webView.url, String(describing: url).starts(with: "whatsapp://") {
//            let whatsAppUrl = String(describing: url).replacingOccurrences(of: "whatsapp://", with: "https://api.whatsapp.com/")
//            //print("start loading whatsapp", webView.url as Any)
//            UIApplication.shared.open(URL(string: whatsAppUrl) ?? url, options: [:], completionHandler: nil)
//        } else if let url = webView.url, String(describing: url).starts(with: "tel:") {
//            let whatsAppUrl = url.absoluteString.replacingOccurrences(of: "tel:", with: "tel://")
//            UIApplication.shared.open(URL(string: whatsAppUrl) ?? url, options: [:], completionHandler: nil)
//        } else if let url = webView.url, String(describing: url).starts(with: "mailto:") {
//            let whatsAppUrl = url.absoluteString.replacingOccurrences(of: "mailto:", with: "mailto://")
//            UIApplication.shared.open(URL(string: whatsAppUrl) ?? url, options: [:], completionHandler: nil)
//        } else {
//            SVProgressHUD.show()
//            UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        }
    }
    
    // Method called at the time of loading url
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
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print(#function)
        decisionHandler(.allow)
    }
    
    // Method called when url loading is completed
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.printURLContent()
        stopWebLoading()
        
        //TODO: - Use this for creating History Page
        //        for page in webView.backForwardList.backList {
        //            print("User visited")
        //            print("\tTitle: \(page.title)\nOriginated From: \(page.initialURL)")
        //            print("\tFull Path: \(page.url.absoluteString)")
        //            print("-----------------")
        //        }
        
        
        //TODO: - For Disabling Text Selection and keyboard event in Webpage
        //        webView.evaluateJavaScript(WKCustomScript.copyPasteSelectionDisableScript().source) { (result, error) in
        //            if let result = result {
        //                print(result)
        //            }
        //        }
        //
    }
    
    // Method called when url loading failed
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        updateProgessBar(value: 0.0)
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
