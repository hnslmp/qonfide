//
//  LoginFormController.swift
//  qonfide
//
//  Created by Hansel Matthew on 13/06/22.
//

import UIKit

class LoginFormController: UIViewController{
    
    // MARK: - Properties
    private let loginImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "catAstroLogo").withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    private let loginTitle: UILabel = {
        let label = UILabel()
        label.text = "Qonfide"
        label.textAlignment = .center
        label.textColor = UIColor(red: 138/255, green: 156/255, blue: 231/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private let usernameTextView: UIStackView = CustomUserTextView(placeholder: "Username")
    
    private let passwordTextView: UIStackView = CustomUserTextView(placeholder: "Password", isSecureField: true)
    
    private let loginButton: AuthButton = {
        let button = AuthButton(title: "Log In", type: .system)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        let attributedTitle = NSMutableAttributedString(string: "Create Account", attributes: [
            .foregroundColor: UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 1),
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                .underlineStyle: NSUnderlineStyle.thick.rawValue
        ])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(guestButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    
    @objc func loginButtonPressed(){
        print("DEBUG: Login Button Pressed")
    }
    
    @objc func guestButtonPressed(){
        print("DEBUG: Login Button Pressed")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        view.backgroundColor = .white
                
        view.addSubview(loginTitle)
        loginTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 0)
        loginTitle.centerX(inView: view)
        
        view.addSubview(loginImageView)
        loginImageView.centerX(inView: view)
        loginImageView.setDimensions(height: 280, width: 280)
        loginImageView.anchor(top: loginTitle.bottomAnchor, paddingTop: 36)
        
        let stack = UIStackView(arrangedSubviews: [usernameTextView, passwordTextView, UIView(), loginButton, createAccountButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: loginImageView.bottomAnchor,paddingTop: 48)
        stack.centerX(inView: view)
    }
}
