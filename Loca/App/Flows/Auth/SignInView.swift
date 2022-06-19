//
//  SignInView.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 17/06/2022.
//

import UIKit

class SignInView: UIView {
    
    var signinButtonHandler: ((String, String) -> Void)?
    
    enum Constants {
        static let signInText = "Let's Sign You In"
        static let loginText = "Email"
        static let passwordText = "Password"
        static let passwordRecoveryText = "Forgot the password?"
        static let imageName = "prev-loca"
        static let fontTitle = UIFont(name: "MuktaMahee Bold", size: 32)
        static let fontRegular = UIFont(name: "MuktaMahee Bold", size: 16)
        static let cianColor = UIColor(red: 0.19, green: 0.69, blue: 0.78, alpha: 1.00)
    }
    
    private var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Constants.fontTitle
        label.text = Constants.signInText
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
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.fontRegular
        label.text = Constants.passwordText
        label.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordStarLabel: UILabel = {
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
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let signinButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Constants.fontRegular
        button.setTitle("Sign In", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Constants.cianColor
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    private let passwordRecoveryButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Constants.fontRegular
        button.setTitle(Constants.passwordRecoveryText, for: .normal)
        button.tintColor = Constants.cianColor
        button.backgroundColor = .white
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
    
    private lazy var passwordStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [passwordLabel, passwordStarLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews:
                                    [image,
                                     signInLabel,
                                     usernameStackView,
                                     usernameTextField,
                                     passwordStackView,
                                     passwordTextField,
                                     signinButton,
                                     passwordRecoveryButton])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(stackView)
        image.image = UIImage(named: Constants.imageName)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        let margins = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: margins.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -160),
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 160),
            image.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        NSLayoutConstraint.activate([
            usernameTextField.heightAnchor.constraint(
                equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(
                equalToConstant: 50),
        ])
        NSLayoutConstraint.activate([
            signinButton.heightAnchor.constraint(
                equalToConstant: 50),
            passwordRecoveryButton.heightAnchor.constraint(
                equalToConstant: 50),
        ])

    }
}
