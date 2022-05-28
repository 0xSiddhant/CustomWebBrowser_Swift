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
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var addNewTabBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet var btnCollections: [UIButton]!
    
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
        backBtn.setTitle("", for: .normal)
        initView()
    }
    
    private func initView() {
        for btn in btnCollections {
            btn.setTitle("", for: .normal)
            btn.tintColor = .primaryColor
        }
    }
    
    
    //MARK: - IBActions
    @IBAction func backBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func addNewTabBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func homeBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func moreBtnAction(_ sender: UIButton) {
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
