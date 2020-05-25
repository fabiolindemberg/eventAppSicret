//
//  EventListModel.swift
//  AppEventTest
//
//  Created by Fabio Lindemberg on 24/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import Foundation

class EventListModel: BaseService {
    
    func getEventList(completion: @escaping (_ events: [Event], _ error: Error?)->Void) {
        
        let endPoint = "events"
        
        request(endPoint: endPoint) { data, error in
            
            guard error == nil else {
                completion([], error)
                return
            }
            
            do {
                let events = try JSONDecoder().decode([Event].self, from: data!)
                completion(events, nil)
            } catch {
                completion([], CustomErrors.conversion(message: "Error to try decode event list."))
            }
        }
    }
}


