//
//  EventDetailModel.swift
//  AppEventTest
//
//  Created by Fabio Lindemberg on 25/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import Foundation

class EventDetailModel: BaseService {
    
    func getEvent(by id: String, completion: @escaping (_ event: Event?,_ error: Error?)->Void) {
        
        let endPoint = "events/\(id)"
        
        request(endPoint: endPoint) { data, error in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let event = try JSONDecoder().decode(Event.self, from: data!)
                completion(event, nil)
            } catch {
                completion(nil, CustomErrors.conversion(message: "Error to try decode event."))
            }
        }
    }
}
