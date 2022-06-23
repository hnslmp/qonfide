//
//  ChatViewModel.swift
//  qonfide
//
//  Created by Hansel Matthew on 23/06/22.
//

import UIKit

protocol ChatViewModelDelegate
{
    func presentChoiceModal(buttons: [String])
    func refreshChat()
}

class ChatViewModel{
    
    // MARK: - Properties
    
    var messages: Array<Message> = []
    
    var counter: Int = 0
    
    var endFlag = true
    
    var delegate: ChatViewModelDelegate!
    
    var userChoice: String = ""
    
    var emotionEffects: Array<String> = ["💼 Work", "🏫 School", "👫🏻 Relationships", "😕 Insecurities", "Others"]
    
    func configureChat(){
        if counter == 0 {
            messages.append(Message(text: "Hey, I'm Bob. I'm here to help you with your emotions. Can you first tell me what is affecting your emotion?", isBobSender: true))
            counter += 1
            configureChat()
        }
        else if counter == 1 {
            delegate.presentChoiceModal(buttons: emotionEffects)
            counter += 1
        }else if counter == 2 {
            messages.append(Message(text: "Hey, Bob. It's mostly because of " + userChoice, isBobSender: false))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }else if counter == 3 {
            messages.append(Message(text: "Can you write how and why " + userChoice + " affects you?", isBobSender: true))
            delegate.refreshChat()
            counter += 1
        }
    }
    
}
