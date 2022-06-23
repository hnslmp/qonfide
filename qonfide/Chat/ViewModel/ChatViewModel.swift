//
//  ChatViewModel.swift
//  qonfide
//
//  Created by Hansel Matthew on 23/06/22.
//

import UIKit

protocol chatViewModelProtocol {
    func presentChoiceModal(buttons: [String])
    func refreshChat()
}

class ChatViewModel{
    
    // MARK: - Properties
    
    var messages: Array<Message> = []
    
    var emotionEffects: Array<String> = ["💼 Work", "🏫 School", "👫🏻 Relationships", "😕 Insecurities", "Others"]
    
    var counter: Int = 0
    
    var endFlag = true
    
    var chatDelegate: chatViewModelProtocol!
    
    var userChoice:String = ""
    
    // MARK: - Lifecyle
    init(){
//        configureChat()
//        messages.append(Message(text: "Hey, I'm Bob. I'm here to help you with your emotions. Can you first tell me what is affecting your emotion?", isBobSender: true))
//        messages.append(Message(text: "Hey, Bob. It's mostly because of School", isBobSender: false))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureChat(){

        if counter == 0 {
            messages.append(Message(text: "Hey, I'm Bob. I'm here to help you with your emotions. Can you first tell me what is affecting your emotion?", isBobSender: true))
            counter += 1
            configureChat()
        }
        else if counter == 1 {
            chatDelegate.presentChoiceModal(buttons: emotionEffects)
//            messages.append(Message(text: "Hey, Bob. It's mostly because of " + userChoice, isBobSender: false))
        }
    }
    
}
//
//extension ChatViewModel: userChoiceInputProtocol{
//
//    func userChose(choice: String) {
//        userChoice = choice
//    }
//
//}
