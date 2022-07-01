//
//  ChangePasswordController.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 19/06/22.
//

import UIKit
import SwiftUI
import Firebase

class ChangePasswordController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    var errorMsg: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        errorMessage.isHidden = true
        errorMessage.numberOfLines = 2
        // Do any additional setup after loading the view.
    }
    
    func updateUserData(password:String) {
        //set current user
        guard let current = Firebase.Auth.auth().currentUser else {
            return
        }
        //db reference
        let db = Firestore.firestore()
        //userRef
        let userRef = db.collection("users")
        //set data to update
        userRef.document(current.uid).setData(["password" : password])
        //create query
//        let query = users.whereField("uid", isEqualTo: current.uid)
        
        //cek data
//        query.getDocuments { snapshot, error in
//            if error == nil {
//                for doc in snapshot!.documents {
//                    print(doc.data()["username"])
//                }
//            }
//        }
    }
    
    @IBAction func didChangePassword(_ sender: Any) {
        let isValid = passwordValidation()
        
        if isValid {
            errorMsg = ""
            errorMessage.isHidden = true
            updateUserData(password: newPasswordField.text!)
            performSegue(withIdentifier: "unwindToSetting", sender: self)
        } else {
            errorMessage.isHidden = false
        }
    }
    
//    func getOldPassword() {
//        guard let user = Auth.auth().currentUser else {
//            return
//        }
////        let db = Firestore.firestore()
////        let userRef = db.collection("users")
////        let query = userRef.whereField("uid", isEqualTo: user.uid)
////
////        print(user.uid)
////        query.getDocuments { sn, err in
////            if err == nil {
////                for doc in sn!.documents {
////                    print(doc.data()[""])
////                }
////            }
////        }
//    }
    
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
