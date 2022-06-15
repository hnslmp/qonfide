//
//  LoginPageController.swift
//  qonfide
//
//  Created by Hansel Matthew on 13/06/22.
//

import UIKit

class LoginPageController: UIViewController{
    
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
        label.textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private let orLimiter: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "orLimiter")?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = AuthButton(title: "Create Account", type: .system)
        button.isEnabled = true
        button.addTarget(self, action: #selector(createAccountPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var alreadyAccountButton: AuthButton = {
        let button = AuthButton(title: "I Already Have an Account", type: .system)
        button.addTarget(self, action: #selector(alreadyAccountPressed), for: .touchUpInside)
        button.isEnabled = true
        button.backgroundColor = UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 1)
        return button
    }()
    
    private lazy var guestButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Continue as guest", attributes: [
                .foregroundColor: UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 1),
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .underlineStyle: NSUnderlineStyle.thick.rawValue])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(guestButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    
    @objc func createAccountPressed(){
        navigationController?.pushViewController(SignupFormController(), animated: true)
    }
    
    @objc func alreadyAccountPressed(){
        navigationController?.pushViewController(LoginFormController(), animated: true)
    }
    
    @objc func guestButtonPressed(){
        print("DEBUG: Continue as guest pressed")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Configure UI
    
    func configureUI(){
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
                
        view.addSubview(loginTitle)
        loginTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 12)
        loginTitle.centerX(inView: view)
        
        view.addSubview(loginImageView)
        loginImageView.centerX(inView: view)
        loginImageView.setDimensions(height: 320, width: 320)
        loginImageView.anchor(top: loginTitle.bottomAnchor, paddingTop: 36)
        
        let stack = UIStackView(arrangedSubviews: [createAccountButton, alreadyAccountButton, orLimiter, guestButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: loginImageView.bottomAnchor, paddingTop: 30)
        stack.centerX(inView: view)
        
    }
}
