//
//  CustomUserTextView.swift
//  qonfide
//
//  Created by Hansel Matthew on 13/06/22.
//

import UIKit

class CustomUserTextView: UIStackView{
    
    let customTextField: CustomUserTextField
    
    init(placeholder: String, isSecureField: Bool? = false)
    {
        customTextField = CustomUserTextField(placeholder: placeholder, isSecureField: isSecureField)
        super.init(frame: .zero)
        
        let title = UILabel()
        title.text = placeholder
        title.textAlignment = .left
        title.textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        
        let spacer = UIView()
        spacer.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        [title, spacer, customTextField].forEach {addArrangedSubview($0)}
        
        axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomUserTextField: UITextField{
    
    init(placeholder: String, isSecureField: Bool? = false){
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 60, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        layer.borderColor = UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 1).cgColor
        layer.cornerRadius = 8
        layer.borderWidth = 2
        
        widthAnchor.constraint(equalToConstant: 320).isActive = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 0.5)])
        isSecureTextEntry = isSecureField!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
