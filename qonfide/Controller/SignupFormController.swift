//
//  SignupFormController.swift
//  qonfide
//
//  Created by Hansel Matthew on 13/06/22.
//

import UIKit

class SignupFormController: UIViewController{
    // MARK: - Properties
    
    private let loginTitle: UILabel = {
        let label = UILabel()
        label.text = "Qonfide"
        label.textAlignment = .center
        label.textColor = UIColor(red: 138/255, green: 156/255, blue: 231/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
//        button.tintColor = .white
        button.setImage(#imageLiteral(resourceName: "selectPhoto"), for: .normal)
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private let emailTextView: UIStackView = CustomUserTextView(placeholder: "Email")
    
    private let usernameTextView: UIStackView = CustomUserTextView(placeholder: "Username")
    
    private let passwordTextView: UIStackView = CustomUserTextView(placeholder: "Password", isSecureField: true)
    
    private let confirmPasswordTextView: UIStackView = CustomUserTextView(placeholder: "Confirm Password", isSecureField: true)
    
    private let createAccountButton: UIButton = {
        let button = AuthButton(title: "Create Accont", type: .system)
        button.addTarget(self, action: #selector(createAccountPressed), for: .touchUpInside)
        return button
    }()
    
    private let alreadyAccountButton: UIButton = {
        let button = UIButton()
        let attributedTitle = NSMutableAttributedString(string: "I Already Have an Account", attributes: [
            .foregroundColor: UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 1),
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                .underlineStyle: NSUnderlineStyle.thick.rawValue
        ])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(alreadyAccountPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    
    @objc func handleSelectPhoto(){
        print("DEBUG: Select Photo Pressed")
    }
    
    @objc func createAccountPressed(){
        print("DEBUG: Create Account Pressed")
    }
    
    @objc func alreadyAccountPressed(){
        print("DEBUG: Already Account Pressed")
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
        
        view.addSubview(selectPhotoButton)
        selectPhotoButton.anchor(top: loginTitle.bottomAnchor, paddingTop: 12)
        selectPhotoButton.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailTextView, usernameTextView, passwordTextView, confirmPasswordTextView, UIView(), createAccountButton, alreadyAccountButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: selectPhotoButton.bottomAnchor,paddingTop: 32)
        stack.centerX(inView: view)
        
    }
}
