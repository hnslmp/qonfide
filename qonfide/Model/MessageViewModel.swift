//
//  MessageViewModel.swift
//  qonfide
//
//  Created by Hansel Matthew on 17/06/22.
//

import Foundation
import UIKit

struct MessageViewModel {
    
    private let message:Message
    
    var messageBackgroundColor: UIColor {
        return message.isBobSender ? UIColor(red: 0.278, green: 0.561, blue: 0.965, alpha: 1.0) : UIColor(red: 0.914, green: 0.914, blue: 0.922, alpha: 1.0)
    }
    
    var messageTextColor: UIColor {
        return message.isBobSender ? .white : .black
    }
    
    var rightAnchorActive: Bool {
        return !message.isBobSender
    }
    
    var leftAnchorActive: Bool {
        return message.isBobSender
    }
    
    var shouldHideProfileImage: Bool {
        return !message.isBobSender
    }
    
    init(message: Message){
        self.message = message
    }
}

