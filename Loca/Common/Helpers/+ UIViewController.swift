//
//  + UIViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 09/08/2022.
//

import UIKit

extension UIViewController {

    func add(childViewController viewController: UIViewController, to contentView: UIView) {

        addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func addToFullView(childViewController viewController: UIViewController, to contentView: UIView) {
        
        add(childViewController: viewController, to: contentView)
        
        let matchParentConstraints = [
            viewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(matchParentConstraints)
    }
    
    func remove() {

        guard parent != nil else { return }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
