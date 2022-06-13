//
//  AuthButton.swift
//  qonfide
//
//  Created by Hansel Matthew on 13/06/22.
//

import UIKit

class AuthButton: UIButton {
    
    init(title: String, type: ButtonType){
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .heavy)
        layer.cornerRadius = 8
        widthAnchor.constraint(equalToConstant: 300).isActive = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

