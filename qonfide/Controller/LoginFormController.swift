//
//  LoginFormController.swift
//  qonfide
//
//  Created by Hansel Matthew on 13/06/22.
//

import UIKit

class LoginFormController: UIViewController{
    
    // MARK: - Properties
    
    private var userModel = LoginViewModel()
    
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
    
    private let emailTextView: CustomUserTextView = CustomUserTextView(placeholder: "Email")
    
    private let passwordTextView: CustomUserTextView = CustomUserTextView(placeholder: "Password", isSecureField: true)
    
    private lazy var loginButton: AuthButton = {
        let button = AuthButton(title: "Log In", type: .system)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        let attributedTitle = NSMutableAttributedString(string: "Create Account", attributes: [
            .foregroundColor: UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 1),
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                .underlineStyle: NSUnderlineStyle.thick.rawValue
        ])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    
    @objc func loginButtonPressed(){
        //TODO: login firebase
        print("DEBUG: Login Button Pressed")
    }
    
    @objc func createAccountButtonPressed(){
        navigationController?.pushViewController(SignupFormController(), animated: true)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextView.customTextField {
            userModel.email = sender.text
        } else {
            userModel.password = sender.text
        }
        
        if userModel.formIsValid {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
            
    
    }
    
    // MARK: - Helpers
    
    func configureTextFieldObserver(){
        [emailTextView, passwordTextView].forEach {
            $0.customTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTextFieldObserver()
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
        
        let stack = UIStackView(arrangedSubviews: [emailTextView, passwordTextView, UIView(), loginButton, createAccountButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: loginImageView.bottomAnchor,paddingTop: 48)
        stack.centerX(inView: view)
    }
}
