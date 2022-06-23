//
//  ButtonOptions.swift
//  qonfide
//
//  Created by Haris Fadhilah on 20/06/22.
//

import Foundation
import UIKit

class ButtonOptions: UIButton{
    
    let buttonOptionColor = UIColor(red: 225/255, green: 237/255, blue: 253/255, alpha: 1)
    
    init(title: String, type: ButtonType) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = buttonOptionColor
        titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .regular)
        setTitleColor(UIColor.black, for: .normal)
        layer.cornerRadius = 8
        widthAnchor.constraint(equalToConstant: 350).isActive = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
