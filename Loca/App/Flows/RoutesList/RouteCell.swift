//
//  RouteCell.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/07/2022.
//

import UIKit

final class RouteCell: UITableViewCell {
    
    static let reuseIdentifier = "RouteCell"
    
    let view = RouteCellView()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        view.routeEntry = nil
    }
    
    func configure(model: Route) {
        view.routeEntry = model
    }
    
    // MARK: - UI
    
    private func configureUI() {
        addSubview(view)
        selectionStyle = .none
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
