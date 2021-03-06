//
//  AuthButton.swift
//  qonfide
//
//  Created by Hansel Matthew on 13/06/22.
//

import UIKit

class AuthButton: UIButton {
    
    let buttonColor = UIColor(red: 53/255, green: 74/255, blue: 166/255, alpha: 1)
    let disabledColor = UIColor(red: 166/255, green: 166/255, blue: 172/255, alpha: 1)
    
    override var isEnabled: Bool { didSet {
        super.isEnabled = isEnabled
        self.backgroundColor = isEnabled ? buttonColor : disabledColor
    }}
    
    init(title: String, type: ButtonType){
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = buttonColor
        titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .heavy)
        layer.cornerRadius = 8
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
