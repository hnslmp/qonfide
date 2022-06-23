//
//  LayoutOptions.swift
//  qonfide
//
//  Created by Haris Fadhilah on 21/06/22.
//

import Foundation
import UIKit

class LayoutOptions: UIStackView {
    
    private let buttonArray: Array<String> = ["😊 Happy","😭 Sad", "😡 Angry", "😮 Surprise", "😔 Bad", "🤢 Disgusted", "😱 Fearful" ]
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(red: 241/255, green: 247/255, blue: 255/255, alpha: 1)
        distribution = .fill
        axis = .vertical
        alignment = .center
        spacing = 12.0
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
