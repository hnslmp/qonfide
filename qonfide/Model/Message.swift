//
//  Message.swift
//  qonfide
//
//  Created by Hansel Matthew on 17/06/22.
//

import Foundation

struct Message{
    let text: String
    let isBobSender: Bool
    
    init(text: String, isBobSender: Bool){
        self.text = text
        self.isBobSender = isBobSender
    }
}
