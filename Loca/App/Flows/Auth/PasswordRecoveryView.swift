//
//  PasswordRecoveryView.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 24/06/2022.
//

import UIKit

class PasswordRecoveryView: UIView {
    
    var buttonHandler: (() -> Void)?
    
    enum Constants {
        static let titleText = "Reset Your Password"
        static let loginText = "Your Email"
        static let buttonText = "Continue"
        static let imageName = "prev-loca"
        static let fontTitle = UIFont(name: "MuktaMahee Bold", size: 32)
        static let fontRegular = UIFont(name: "MuktaMahee Bold", size: 16)
        static let cianColor = UIColor(red: 0.19, green: 0.69, blue: 0.78, alpha: 1.00)
    }
    
    // MARK: - Subviews
    
    private var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleText
        label.textAlignment = .center
        label.font = Constants.fontTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.fontRegular
        label.text = Constants.loginText
        label.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameStarLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.fontRegular
        label.textColor = UIColor.red
        label.text = "*"
        label.setContentHuggingPriority(.init(rawValue: 250), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let goButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.buttonText, for: .normal)
        button.titleLabel?.font = Constants.fontRegular
        button.tintColor = .white
        button.backgroundColor = Constants.cianColor
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var usernameStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [usernameLabel, usernameStarLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews:
                                    [titleLabel,
                                     usernameStackView,
                                     usernameTextField,
                                     goButton])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private methods
    
    private func setupView() {
        backgroundColor = .white
        addSubview(image)
        addSubview(stackView)
        image.image = UIImage(named: Constants.imageName)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        let margins = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: margins.topAnchor),
            image.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: image.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 160),
            image.heightAnchor.constraint(equalToConstant: 160),
        ])
        
        NSLayoutConstraint.activate([
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            goButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
