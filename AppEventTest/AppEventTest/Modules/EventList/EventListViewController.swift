//
//  EventListViewController.swift
//  AppEventTest
//
//  Created by Fabio Lindemberg on 24/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController {

    var viewModel: EventListViewModel?
    var activityIndicator: UIActivityIndicatorView?
    var lblMessage = UILabel()
    
    @IBOutlet weak var tbEvent: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        tbEvent.tableFooterView = UIView()
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.startAnimating()
        
        viewModel = EventListViewModel(model: EventListModel())
        viewModel!.updateUI = updateUI

        tbEvent.dataSource = self
    }
    
    func updateUI(_ state: ViewState) {
        DispatchQueue.main.async {
            switch state {
            case .loading:
                self.tbEvent.backgroundView = self.activityIndicator
            case .update:
                self.tbEvent.reloadData()
                self.tbEvent.backgroundView = nil
            case .error:
                self.lblMessage.numberOfLines = 0
                self.lblMessage.text = self.viewModel?.errorMessage ?? ""
                self.tbEvent.backgroundView = self.lblMessage
            case .noData:
                self.lblMessage.text = "Sem dados"
                self.tbEvent.backgroundView = self.lblMessage
            case .initial:
                self.tbEvent.backgroundView = nil
            }
        }
    }
}

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel!.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = viewModel!.events[indexPath.row].title
        return cell!
    }
}
