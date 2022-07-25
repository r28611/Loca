//
//  RoutesListView.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/07/2022.
//

import UIKit

final class RoutesListView: UIView {
    
    // MARK: - Subviews
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 120
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RouteCell.self, forCellReuseIdentifier: RouteCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        backgroundColor = AppColors.background
        addViews()
        setupConstraints()
    }
    
    private func addViews() {
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        let margins = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -8),
            tableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
}
