//
//  NewTabViewController.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 28/05/22.
//  Copyright (c) 2022. All rights reserved.
//

import UIKit

protocol NewTabViewProtocol: BaseView {
    func displaySomething()
}

class NewTabViewController: BaseViewController {
    var presenter: NewTabPresenterProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - NewTabViewController
extension NewTabViewController: NewTabViewProtocol {
    func displaySomething() {
        // TODO: Update UI
    }
}

