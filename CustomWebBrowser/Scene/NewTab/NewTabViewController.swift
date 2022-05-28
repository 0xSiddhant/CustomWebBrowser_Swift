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
    @IBOutlet weak var searchView: BaseSearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.searchText = { [weak self] str in
            self?.presenter?.generateURL(with: str)
        }
        webView.navigationDelegate = self
    }
}

// MARK: - NewTabViewController
extension NewTabViewController: NewTabViewProtocol {
    func openURL(with req: URLRequest) {
        searchView.isHidden = true
        webView.load(req)
    }
}

//MARK: - Webkit Delegate
extension NewTabViewController: WKNavigationDelegate {
    
}
