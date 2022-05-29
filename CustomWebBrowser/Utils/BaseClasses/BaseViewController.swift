//
//  BaseViewController.swift
//  TestViper
//
//  Created by Ankit Sabharwal on 09/02/22.
//

import UIKit
import WebKit

class BaseViewController: UIViewController {
    var completionSegue: (BaseViewController) -> Void  = { _ in }
    var identifier: String!
    weak var scrollView: UIScrollView?
    var documentUrl: URL?
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero, configuration: WKCustomConfigurator.create())
        webView.scrollView.refreshControl = UIRefreshControl()
        webView.scrollView.refreshControl?.addTarget(self, action: #selector(startLoading), for: .valueChanged)
        return webView
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    open func performSegue(aIdentifier: String, aCompletion: @escaping (BaseViewController) -> Void) {
        completionSegue = aCompletion
        identifier = aIdentifier
        performSegue(withIdentifier: aIdentifier, sender: nil)
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tapGust = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGust.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGust)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == identifier) {
            if let destination = segue.destination as? BaseViewController {
                completionSegue(destination)
            }
        }
    }
    
    var rightBarButtons = [UIBarButtonItem]() {
        didSet {
            self.navigationItem.rightBarButtonItems = rightBarButtons
        }
    }
    
    var leftBarButtons = [UIBarButtonItem]() {
        didSet {
            self.navigationItem.leftBarButtonItems = leftBarButtons
        }
    }
    
    func setNavTitle(_ title: String, textAlignment: NSTextAlignment = .left) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.navigationController?.navigationBar.bounds.width ?? 0, height: self.navigationController?.navigationBar.bounds.height ?? 0))
        label.text = title
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = textAlignment
        self.navigationItem.titleView = label
    }
}

extension BaseViewController: BaseView {
    @objc func startLoading() {
        webView.reload()
    }
    
    func stopLoading() {
        webView.scrollView.refreshControl?.endRefreshing()
    }
    
    func showError(message: String) {
        
    }
    
    func showGeneralError(title: String, message: String, completion: @escaping (() -> Void), buttonTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: {_ in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}



extension BaseViewController:  URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        try? FileManager.default.removeItem(at: destinationURL)
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            print("Downloaded File Path: ", destinationURL.absoluteString)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func clearCache() {
        if let url = self.documentUrl {
            try? FileManager.default.removeItem(at: url)
            self.documentUrl = nil
        }
    }
}
