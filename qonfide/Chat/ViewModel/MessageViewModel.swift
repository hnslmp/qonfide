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
        return message.isBobSender ? UIColor(red: 254/255, green: 235/255, blue: 166/255, alpha: 1.0) : UIColor(red: 225/255, green: 237/255, blue: 253/255, alpha: 1.0)
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

