//
//  AuthView.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 17/06/2022.
//

import UIKit

class AuthView: UIView {
    
    var goButtonHandler: ((String?, String?) -> Void)?
    var passwordRecoveryButtonHandler: (() -> Void)?
    var textFieldsDidChangedHandler: ((String?, String?) -> Void)?
    
    enum Constants {
        static let imageName = "prev-loca"
        static let fontTitle = UIFont(name: "MuktaMahee Bold", size: 32)
        static let fontRegular = UIFont(name: "MuktaMahee Bold", size: 16)
        static let cianColor = UIColor(red: 0.19, green: 0.69, blue: 0.78, alpha: 1.00)
    }
    
    //MARK: Private properties
    
    private var isAccountExist: Bool = false
    
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
        label.textAlignment = .center
        label.font = Constants.fontTitle
        label.text = Text.signIn
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.fontRegular
        label.text = Text.email
        label.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameStarLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.fontRegular
        label.textColor = UIColor.red
        label.text = Text.starSimbol
        label.setContentHuggingPriority(.init(rawValue: 250), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.fontRegular
        label.text = Text.password
        label.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordStarLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.fontRegular
        label.textColor = UIColor.red
        label.text = Text.starSimbol
        label.setContentHuggingPriority(.init(rawValue: 250), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let goButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Constants.fontRegular
        button.tintColor = .white
        button.backgroundColor = Constants.cianColor
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let passwordRecoveryButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Constants.fontRegular
        button.setTitle(Text.forgotPassword, for: .normal)
        button.tintColor = Constants.cianColor
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let accountStateccountLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.fontRegular
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let accountStateButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Constants.fontRegular
        button.contentHorizontalAlignment = .left
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
    
    private lazy var accountStateStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [accountStateccountLabel, accountStateButton])
        stack.axis = .horizontal
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var accountStateView: UIView = {
        let view = UIView()
        view.addSubview(accountStateStackView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews:
                                    [titleLabel,
                                     usernameStackView,
                                     usernameTextField,
                                     passwordStackView,
                                     passwordTextField,
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
        addSubview(passwordRecoveryButton)
        addSubview(accountStateView)
        image.image = UIImage(named: Constants.imageName)
        setupConstraints()
        setupSignText()
        setButtonsActions()
        setTextFieldsActions()
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
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            goButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            passwordRecoveryButton.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            passwordRecoveryButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            passwordRecoveryButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            passwordRecoveryButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            accountStateView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            accountStateView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            accountStateView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            accountStateStackView.centerXAnchor.constraint(equalTo: accountStateView.centerXAnchor),
            accountStateStackView.topAnchor.constraint(equalTo: accountStateView.topAnchor),
            accountStateStackView.bottomAnchor.constraint(equalTo: accountStateView.bottomAnchor),
        ])
    }
    
    private func setupSignText() {
        if isAccountExist {
            titleLabel.text = Text.letsSignIn
            goButton.setTitle(Text.signIn, for: .normal)
            accountStateccountLabel.text = Text.dontHaveAccount
            accountStateButton.setTitle(Text.signUp, for: .normal)
            
            passwordRecoveryButton.isHidden = false
        } else {
            titleLabel.text = Text.createAccount
            goButton.setTitle(Text.signUp, for: .normal)
            accountStateccountLabel.text = Text.haveAccount
            accountStateButton.setTitle(Text.signIn, for: .normal)
            
            passwordRecoveryButton.isHidden = true
        }
    }
    
    private func setButtonsActions() {
        accountStateButton.addTarget(self, action: #selector(toogleAccountState), for: .touchUpInside)
        goButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        passwordRecoveryButton.addTarget(self, action: #selector(passwordRecoveryButtonTapped), for: .touchUpInside)
    }
    
    private func setTextFieldsActions() {
        usernameTextField.addTarget(self, action: #selector(textFieldsDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsDidChanged), for: .editingChanged)
    }
    
    @objc private func toogleAccountState() {
        isAccountExist.toggle()
        setupSignText()
    }
    
    @objc private func goButtonTapped() {
        goButtonHandler?(self.usernameTextField.text, self.passwordTextField.text)
    }
    
    @objc private func passwordRecoveryButtonTapped() {
        passwordRecoveryButtonHandler?()
    }
    
    @objc private func textFieldsDidChanged() {
        textFieldsDidChangedHandler?(self.usernameTextField.text, self.passwordTextField.text)
    }
}
