//
//  CustomTabBar.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 24/07/2022.
//

import UIKit

final class CustomTabBar: UITabBar {
    
    var middleButtonHandler: (() -> Void)?
    
    // MARK: - Properties
    
    private var tabBarWidth: CGFloat { self.bounds.width }
    private var tabBarHeight: CGFloat { self.bounds.height }
    private var centerWidth: CGFloat { self.bounds.width / 2 }
    private let circleRadius: CGFloat = 32
    
    private var shapeLayer: CALayer? = nil
    private var circleLayer: CALayer? = nil
    
    private let middleButtonDiameter: CGFloat = 42

    private lazy var middleButton: UIButton = {
        let middleButton = UIButton()
        middleButton.layer.cornerRadius = middleButtonDiameter / 2
        middleButton.backgroundColor = AppColors.background
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        middleButton.addTarget(self, action: #selector(didPressMiddleButton), for: .touchUpInside)
        return middleButton
    }()
    
    private lazy var middleButtonImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = UIImage(systemName: "record.circle")
        heartImageView.tintColor = AppColors.pink
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()
    
    // MARK: - Overriden Methods
    
    override func draw(_ rect: CGRect) {
        drawTabBar()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointIsInside = super.point(inside: point, with: event)
        if pointIsInside == false {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return pointIsInside
    }
    
    // MARK: - Private Methods
    
    @objc private func didPressMiddleButton() {
        middleButtonHandler?()
    }
    
    private func makeUI() {
        
        let appearance = UITabBarAppearance()
        setTabBarItemColors(appearance.stackedLayoutAppearance)
        standardAppearance = appearance

        addSubview(middleButton)
        middleButton.addSubview(middleButtonImageView)
        
        NSLayoutConstraint.activate([

            middleButton.heightAnchor.constraint(equalToConstant: middleButtonDiameter),
            middleButton.widthAnchor.constraint(equalToConstant: middleButtonDiameter),

            middleButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            middleButton.topAnchor.constraint(equalTo: topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([

            middleButtonImageView.heightAnchor.constraint(equalToConstant: 26),
            middleButtonImageView.widthAnchor.constraint(equalToConstant: 26),

            middleButtonImageView.centerXAnchor.constraint(equalTo: middleButton.centerXAnchor),
            middleButtonImageView.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)
        ])
    }
    
    private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.iconColor = AppColors.lightGray
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        
        itemAppearance.selected.iconColor = AppColors.cian
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColors.cian]
    }
    
    private func drawTabBar() {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapePath()
        shapeLayer.strokeColor = AppColors.lightGray.cgColor
        shapeLayer.fillColor = AppColors.background.cgColor
        shapeLayer.lineWidth = 1.0

        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath()
        circleLayer.strokeColor = AppColors.lightGray.cgColor
        circleLayer.fillColor = AppColors.background.cgColor
        circleLayer.lineWidth = 1.0

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        if let oldCircleLayer = self.circleLayer {
            self.layer.replaceSublayer(oldCircleLayer, with: circleLayer)
        } else {
            self.layer.insertSublayer(circleLayer, at: 1)
        }

        self.shapeLayer = shapeLayer
        self.circleLayer = circleLayer
        
        makeUI()
    }
    
    private func shapePath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: tabBarWidth, y: 0))
        path.addLine(to: CGPoint(x: tabBarWidth, y: tabBarHeight))
        path.addLine(to: CGPoint(x: 0, y: tabBarHeight))
        path.close()
        return path.cgPath
    }
    
    private func circlePath() -> CGPath {
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: centerWidth, y: 12),
                    radius: circleRadius,
                    startAngle: 180 * .pi / 180,
                    endAngle: 0 * 180 / .pi,
                    clockwise: true)
        return path.cgPath
    }
}
