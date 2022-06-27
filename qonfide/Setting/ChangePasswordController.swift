//
//  ChangePasswordController.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 19/06/22.
//

import UIKit
import SwiftUI

class ChangePasswordController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    var errorMsg: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.isHidden = true
        errorMessage.numberOfLines = 2
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangePassword(_ sender: Any) {
        let isValid = passwordValidation()
        
        if isValid {
            errorMsg = ""
            errorMessage.isHidden = true
            let storyboard = UIStoryboard(name: "Settings", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SettingView")
            vc.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            errorMessage.isHidden = false
        }
    }
    
    func passwordValidation() -> Bool {
        let oldPassword = passwordField.text!
        let newPassword = newPasswordField.text!
        let confirmPassword = confirmPasswordField.text!
        
//        1. there is no empty field
        if oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty {
            errorMsg = "Text field cannot be empty!"
            errorMessage.text = errorMsg
            return false
        }
//        2. if new password == old password
        else if newPassword == oldPassword {
            errorMsg = "New password must be different with old password!"
            errorMessage.text = errorMsg
            return false
        }
//        3. new password != confirm password
        else if newPassword != confirmPassword {
            errorMsg = "New password must be the same with confirm password!"
            errorMessage.text = errorMsg
            return false
        }
        return true
    }
    
}
