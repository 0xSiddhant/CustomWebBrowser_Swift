//
//  NewTabInteractor.swift
//  CustomWebBrowser
//
//  Created by Siddhant Kumar on 28/05/22.
//  Copyright (c) 2022. All rights reserved.
//

import UIKit

protocol NewTabInteractorProtocol {
    func startDoingSomething()
}

final class NewTabInteractor: BaseInteractor, NewTabInteractorProtocol {
    var presenter: NewTabPresenterProtocol?
        
    // MARK: - API calls
    
    func startDoingSomething() {
//        worker.getSomething(aQueryString: "") { (aAny) in
//            self.model = aAny
//            
//            //Convert Any object to Response Model
//        }
    }
    
    // MARK: - Business logic
    
    
}

