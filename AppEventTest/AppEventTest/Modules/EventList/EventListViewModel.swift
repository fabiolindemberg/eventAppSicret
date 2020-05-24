//
//  EventListViewModel.swift
//  AppEventTest
//
//  Created by Fabio Lindemberg on 24/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import Foundation

protocol EventListViewModelDelegate {
    func loading(_ toogle: Bool)
    func fail(message: String)
    func dataLoaded()
}

protocol EvenView {
    var description: String { get set }
    var image: String { get set }
    var title: String { get set }
}

class EventListViewModel {
    
    private var model: EventListModel
    private var events: [Event] = []
    
    var delegate: EventListViewModelDelegate?
    
    init(model: EventListModel) {
        self.model = model
    }
    
    func loadData() {
        self.delegate?.loading(true)
        model.getEventList() { events, error in
            
            self.delegate?.loading(false)
            
            guard error == nil else {
                
                self.delegate?.fail(message: error!.localizedDescription)
                return
            }
            
            self.events = events
            self.delegate?.dataLoaded()
        }
    }
    
    func eventCount() -> Int {
        return events.count
    }
    
    func fillUI(index: Int, eventView: EvenView) {
        var ev = eventView
        
        let event = events[index]
        ev.description = event.welcomeDescription
        ev.image = event.image
        ev.title = event.title

    }
}
