//
//  CustomMessageTextView.swift
//  qonfide
//
//  Created by Haris Fadhilah on 21/06/22.
//

import Foundation
import UIKit

class CustomMessageTextView: UIStackView {

    let customTextField: CustomMessageTextField
    
    private lazy var sendButton: UIButton = {
        print("di")
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1), for: .normal)        
        return button
    }()
    
    init(placeholder: String) {
        
        customTextField = CustomMessageTextField(placeholder: placeholder)

        super.init(frame: .zero)
        
//        let spacer = UIView()
//        spacer.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        [customTextField, sendButton].forEach {addArrangedSubview($0)}
        
        axis = .vertical
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomMessageTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 60, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        layer.borderColor = UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 0).cgColor
        layer.backgroundColor = UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 0.2).cgColor
        layer.cornerRadius = 8
        layer.borderWidth = 2
        
        widthAnchor.constraint(equalToConstant: 320).isActive = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 0.5)])
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}
