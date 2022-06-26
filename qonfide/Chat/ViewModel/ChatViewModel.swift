//
//  ChatViewModel.swift
//  qonfide
//
//  Created by Hansel Matthew on 23/06/22.
//

import UIKit

protocol ChatViewModelDelegate
{
    func presentChoiceModal(buttons: [String], counter: Int)
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
    
    var options2: Array<String> = ["😊 Happy", "😭 Sad", "😡 Angry", "😮 Surprised", "😔 Bad", "🤢 Disgusted", "😱 Fearful"]
    
    var options3: Array<String> = ["A little", "Moderately", "Very", "Extremely"]
    
    var options4: Array<String> = ["Yeah sure", "I don't think I need it now"]
    
    func configureChat(){
        print(userChoice)
        if counter == 0 {
            print("COUNTER \(counter)")
            messages.append(Message(text: "Hey, I'm Bob. I'm here to help you with your emotions. Can you first tell me what is affecting your emotion?", isBobSender: true))
            counter += 1
            configureChat()
        }
        else if counter == 1 {
            print("COUNTER \(counter)")
            delegate.presentChoiceModal(buttons: emotionEffects, counter: self.counter)
            counter += 1
        }else if counter == 2 {
            print("COUNTER \(counter)")
            messages.append(Message(text: "Hey, Bob. It's mostly because of " + userChoice, isBobSender: false))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }else if counter == 3 {
            print("COUNTER \(counter)")
            messages.append(Message(text: "Can you write how and why " + userChoice + " affects you?", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
            print("harusnua uda 4 \(counter)")
        }else if counter == 4 {
            print("masuk counter 4")
            print("COUNTER \(counter)")
            delegate.presentChoiceModal(buttons: options2, counter: self.counter)
            delegate.refreshChat()
            counter += 1
        }else if counter == 5 {
            print("COUNTER \(counter)")
            messages.append(Message(text: userChoice, isBobSender: false))
            delegate.refreshChat()
            counter += 1
            print("di-enter niii")
        }else if counter == 6 {
            messages.append(Message(text: "That must be uncomfortable for you.", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }else if counter == 7 {
            messages.append(Message(text: "How did this situation make you feel?", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }else if counter == 8 {
            delegate.presentChoiceModal(buttons: options2, counter: self.counter)
            counter += 1
        }else if counter == 9 {
            messages.append(Message(text: "It mostly makes me feel " + userChoice, isBobSender: false))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }else if counter == 10 {
            messages.append(Message(text: "It’s okay to feel " + userChoice + ". Anyone would feel " + userChoice + " in this situation.", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }else if counter == 11 {
            messages.append(Message(text: "How intense are your " + userChoice + " right now?" + userChoice, isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 12 {
            print("COUNTER \(counter)")
            delegate.presentChoiceModal(buttons: options3, counter: self.counter)
            counter += 1
        }
        else if counter == 13 {
            messages.append(Message(text: "I Feel a " + userChoice, isBobSender: false))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 14 {
            messages.append(Message(text: "It's good that you can try to figure out how intense your emotion is.", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 15 {
            messages.append(Message(text: "Have you tried to do something to make yourself feel better?", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 15 {
            messages.append(Message(text: "Have you tried to do something to make yourself feel better?", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
    }
    
}
