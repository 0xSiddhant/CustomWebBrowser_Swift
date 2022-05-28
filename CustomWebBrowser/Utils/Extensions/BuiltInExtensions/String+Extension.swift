//
//  String+Extension.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 28/05/22.
//

import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
