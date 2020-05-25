//
//  EventDetailViewController.swift
//  AppEventTest
//
//  Created by Fabio Lindemberg on 25/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    var viewModel = EventDetailViewModel(model: EventDetailModel())
    var eventId: String? {
        didSet {
            viewModel.loadData(eventId: eventId!)
        }
    }
    
    fileprivate func configUI() {
        lblTitle.alpha = 0
        imgEvent.alpha = 0
        lblDescription.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        viewModel.updatUI = self.uptateUI
    }
    
    func uptateUI(_ state: ViewState) {
        DispatchQueue.main.async {
            switch state {
                
            case .loading:
                self.configUI()
            case .update:
                self.loadUI()
            case .error:
                self.configUI()
            case .initial:
                self.configUI()
            case .noData:
                self.configUI()
            }
        }
    }
    
    func loadUI() {
        if let _ = viewModel.event {
            lblTitle.text = viewModel.event?.title
            lblDescription.text = viewModel.event?.welcomeDescription
            imgEvent.sd_setImage(with: URL(string: viewModel.event?.image ?? ""), placeholderImage: #imageLiteral(resourceName: "mountain"))
        }
        
        UIView.animate(withDuration: 0.3) {
            self.lblTitle.alpha = 1
            self.imgEvent.alpha = 1
            self.lblDescription.alpha = 1
        }
    }
}
