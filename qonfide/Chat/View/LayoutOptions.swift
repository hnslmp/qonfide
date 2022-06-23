//
//  LayoutOptions.swift
//  qonfide
//
//  Created by Haris Fadhilah on 21/06/22.
//

import Foundation
import UIKit

class LayoutOptions: UIStackView {
    
//    private let buttonArray: Array<String> = ["😊 Happy","😭 Sad", "😡 Angry", "😮 Surprise", "😔 Bad", "🤢 Disgusted", "😱 Fearful" ]
    
    var buttonArray: Array<String> = []
    
    init(buttons: [String]) {
        super.init(frame: .zero)
        
        buttonArray = buttons
        
       
        
        countButton()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func countButton() {
        for value in buttonArray {
            let button = ButtonOptions(title: value, type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 346).isActive = true
            addArrangedSubview(button)
        }
    }
}
