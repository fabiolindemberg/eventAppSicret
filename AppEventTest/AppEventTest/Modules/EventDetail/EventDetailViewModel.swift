//
//  EventDetailViewModel.swift
//  AppEventTest
//
//  Created by Fabio Lindemberg on 25/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import Foundation

class EventDetailViewModel {
    
    private var model: EventDetailModel
    var event: Event?
    var updatUI: ((_ state: ViewState)->())?
    var errorMessage: String?
    var state: ViewState = .initial {
        didSet {
            updatUI?(state)
        }
    }
    
    init(model: EventDetailModel) {
        self.model = model
    }
    
    func loadData(eventId: String) {
        model.getEvent(by: eventId) { event, error in
            guard error == nil else {
                self.errorMessage = error!.localizedDescription
                self.state = .error
                return
            }
            
            self.event = event
            
            self.state = event == nil ? .noData : .update
        }
    }
    
}
