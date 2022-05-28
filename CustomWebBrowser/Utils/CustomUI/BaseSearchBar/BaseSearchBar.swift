//
//  BaseSearchBar.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 28/05/22.
//

import UIKit

@IBDesignable
class BaseSearchBar: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var voiceSearchBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchMsgLbl: UILabel!
    
    var searchText: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("BaseSearchBar", owner: self)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        initView()
    }
    
    private func initView() {
        voiceSearchBtn.setTitle("", for: .normal)
        
        textField.delegate = self
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = textField.frame.size.height/2
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftViewMode = .always
        
        voiceSearchBtn.tintColor = .primaryColor
    }
    
    @IBAction func voiceSearchAction(_ sender: UIButton) {
        
    }
}

extension BaseSearchBar: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchMsgLbl.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            searchMsgLbl.isHidden = !text.isEmpty
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if !text.isEmpty {
                searchText?(text)
            }
        }
        textField.endEditing(true)
        return true
    }
}
