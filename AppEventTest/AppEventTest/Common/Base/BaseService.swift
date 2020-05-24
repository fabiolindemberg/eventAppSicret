//
//  BaseService.swift
//  AppEventTest
//
//  Created by Fabio Lindemberg on 24/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import Foundation

class BaseService {
    
    private let baseUrl = "http://5b840ba5db24a100142dcd8c.mockapi.io/api/"
    
    func request(endPoint: String, completion: @escaping (_ data: Data?, _ error: Error?)->Void) {
        
        guard let url = URL(string: baseUrl + endPoint) else {
            completion(nil, CustomErrors.api(message: "Invalid URL"))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            let code = (response as! HTTPURLResponse).statusCode
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard code == 200 else {
                completion(nil, CustomErrors.api(message: "Response code: \(code)"))
                return
            }
            
            completion(data, nil)
        }
        
    }
    
}

enum CustomErrors: Error {
    case api(message: String)
    case conversion(message: String)
}
