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
    func presentTextModal()
//    func resetContentOffset()
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
    
    var emotionString: String = ""
    
    var options2: Array<String> = ["😊 Happy", "😭 Sad", "😡 Angry", "😮 Surprised", "😔 Bad", "🤢 Disgusted", "😱 Fearful"]
    
    var options3: Array<String> = ["A little", "Moderately", "Very", "Extremely"]
    
    var options4: Array<String> = ["Yeah sure", "I don't think I need it now"]
    
    func configureChat(){
        print(userChoice)
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
            configureChat()
        }else if counter == 4 {
            delegate.presentTextModal()
            counter += 1
        }else if counter == 5 {
            messages.append(Message(text: userChoice, isBobSender: false))
            delegate.refreshChat()
            counter += 1
            configureChat()
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
        }
        else if counter == 8 {
            delegate.presentChoiceModal(buttons: options2)
            counter += 1
        }
        else if counter == 9 {
            messages.append(Message(text: "It mostly makes me feel " + userChoice, isBobSender: false))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 10 {
            messages.append(Message(text: "It’s okay to feel " + userChoice + ". Anyone would feel " + userChoice + " in this situation.", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }else if counter == 11 {
            messages.append(Message(text: "How intense are your " + userChoice + " right now?", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 12 {
            delegate.presentChoiceModal(buttons: options3)
            counter += 1
        }
        else if counter == 13 {
            messages.append(Message(text: "I Feel " + userChoice + " " + emotionString, isBobSender: false))
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
        else if counter == 16 {
            delegate.presentTextModal()
            counter += 1
        }
        else if counter == 17 {
            messages.append(Message(text: userChoice, isBobSender: false))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 18 {
            messages.append(Message(text: "That is great. It takes time to calm yourself down from feeling an intense emotion like " + emotionString, isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 19 {
            messages.append(Message(text: "Would you want to receive an activity suggestion that might help you?", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 20 {
            delegate.presentChoiceModal(buttons: options4)
            counter += 1
        }
        else if counter == 21 {
            messages.append(Message(text: userChoice, isBobSender: false))
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 22 {
            messages.append(Message(text: "Here is a suggestion when you're feeling " + emotionString + " : \n 1. Slowly repeat a calm word or phrase such as 'relax,' 'take it easy.' Repeat it to yourself while breathing deeply. \n \n 2. Use imagery; visualize a relaxing experience, from either your memory or your imagination. \n \n 3. Non-strenuous, slow yoga-like exercises can relax your muscles and make you feel much calmer.", isBobSender: true))
            messages.append(Message(text: "Don't forget to check-in your emotion later", isBobSender: true))
            delegate.refreshChat()
        }
    }
}
