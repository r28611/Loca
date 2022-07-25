//
//  RoutesListController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/07/2022.
//

import UIKit

final class RoutesListController: UIViewController {
    
    private var routesListView: RoutesListView {
        return self.view as! RoutesListView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = RoutesListView()
        setupTableView()
    }
    
    private func setupTableView() {
        routesListView.tableView.dataSource = self
        routesListView.tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension RoutesListController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RouteCell.reuseIdentifier,
                                                       for: indexPath) as? RouteCell
                
        else { return RouteCell() }
        
        cell.configure(model: Route(startDate: Date(), endDate: Date(), coordinates: [Location()]))
        
        return cell
    }
}
