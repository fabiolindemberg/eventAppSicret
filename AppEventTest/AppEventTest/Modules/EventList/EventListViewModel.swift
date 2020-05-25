//
//  EventListViewModel.swift
//  AppEventTest
//
//  Created by Fabio Lindemberg on 24/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import Foundation

class EventListViewModel {
    
    private var model: EventListModel
    var events: [Event] = []
    var errorMessage: String = ""
    var updateUI: ((_ state: ViewState)->())? {
        didSet {
            self.loadData()
        }
    }
    
    var state: ViewState = .initial {
        didSet {
            updateUI?(state)
        }
    }
    
    init(model: EventListModel) {
        self.model = model
    }
    
    private func loadData() {
        self.state = .loading
        model.getEventList() { events, error in
            
            guard error == nil else {
                self.errorMessage = error!.localizedDescription
                self.state = .error
                return
            }
            
            self.events = events
            
            self.state = events.count == 0 ? .noData : .update
        }
    }
}
