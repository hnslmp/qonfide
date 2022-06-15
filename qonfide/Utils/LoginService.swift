//
//  LoginService.swift
//  qonfide
//
//  Created by Hansel Matthew on 14/06/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct AuthCredentials{
    let email: String
    let username: String
    let password: String
    let profileImage: UIImage
}

struct LoginService{
    
    static func logUserIn(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping ((Error?) -> Void)){
        
        Service.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password){
                (result, error) in
                
                if let error = error {
                    print("DEBUG: Error signing user up \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else {return}
                
                let data = ["email": credentials.email, "username": credentials.username, "imageUrl": imageUrl, "uid": uid, "age": 18] as [String : Any]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
        
    }
}

