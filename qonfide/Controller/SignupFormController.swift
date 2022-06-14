//
//  SignupFormController.swift
//  qonfide
//
//  Created by Hansel Matthew on 13/06/22.
//

import UIKit

class SignupFormController: UIViewController{
    // MARK: - Properties
    
    private var userModel = SignupViewModel()
    
    private var profileImage: UIImage?
    
    private let loginTitle: UILabel = {
        let label = UILabel()
        label.text = "Qonfide"
        label.textAlignment = .center
        label.textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    private lazy var selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
//        button.tintColor = .white
        button.setBackgroundImage(#imageLiteral(resourceName: "selectPhoto"), for: .normal)
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private let emailTextView: CustomUserTextView = CustomUserTextView(placeholder: "Email")
    
    private let usernameTextView: CustomUserTextView = CustomUserTextView(placeholder: "Username")
    
    private let passwordTextView: CustomUserTextView = CustomUserTextView(placeholder: "Password", isSecureField: true)
    
    private let confirmPasswordTextView: CustomUserTextView = CustomUserTextView(placeholder: "Confirm Password", isSecureField: true)
    
    private lazy var createAccountButton: AuthButton = {
        let button = AuthButton(title: "Create Account", type: .system)
        button.addTarget(self, action: #selector(createAccountPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var alreadyAccountButton: UIButton = {
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
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true,completion: nil)
    }
    
    @objc func createAccountPressed(){
        if userModel.passwordIsValid {
            //TODO : Bikin account
            //TODO : Pindah ke main screen
        } else {
            passwordMisMatchAlert()
        }
    }
    
    @objc func alreadyAccountPressed(){
        navigationController?.pushViewController(LoginFormController(), animated: true)
    }
    
    @objc func textDidChange(sender:
                             UITextField){
    
        if sender == emailTextView.customTextField {
            userModel.email = sender.text
        } else if sender == usernameTextView.customTextField {
            userModel.username = sender.text
        } else if sender == passwordTextView.customTextField {
            userModel.password = sender.text
        } else if sender == confirmPasswordTextView.customTextField {
            userModel.confirmedPassword = sender.text
        }

        if userModel.formIsValid {
            createAccountButton.isEnabled = true
            
        } else {
            createAccountButton.isEnabled = false
        }
        
    }
    
    // MARK: - Helpers
    
    func configureTextFieldObserver(){
        [emailTextView, usernameTextView, passwordTextView, confirmPasswordTextView].forEach {
            $0.customTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        }
    }
    
    func passwordMisMatchAlert(){
        let alert = UIAlertController(title: "Password Mismatch", message: "Password and confirmed password are not the same", preferredStyle: .alert)
        
        alert.view.tintColor = UIColor(red: 53/255, green: 74/255, blue: 166/255, alpha: 1)
        
        alert.addAction(UIAlertAction(
            title: "Dismiss",
            style: .destructive,
            handler: { action in
            })
        )
        
        present(alert, animated: true)
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
        loginTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 12)
        loginTitle.centerX(inView: view)
        
        view.addSubview(selectPhotoButton)
        selectPhotoButton.setDimensions(height: 150, width: 150)
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

extension SignupFormController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        selectPhotoButton.layer.borderWidth = 3
        selectPhotoButton.layer.cornerRadius = selectPhotoButton.layer.bounds.width / 22
        selectPhotoButton.clipsToBounds = true
        
        dismiss(animated: true,completion: nil)
    }
   
}
