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
    func setParam(message: [String])
    func sentimentAnalyst(message: String) -> Double
}

let negativeResponse: Array<String> = ["That must be uncomfortable for you.","I'm sorry you are going through this.","That sucks...","This experience must be hard for you.","That sounds challenging.","I'm here to help you with your emotions.","I'm glad that you try to confide here."]

let positiveResponse: Array<String> = ["I'm happy to hear that😊😊", "It must be a pleasant experience for you😄"]

let validateHappy: Array<String> = ["It's great to know you're feeling happy right now.","I'm happy for you.."]

let validateAnger: Array<String> = ["It’s okay to feel angry. Anyone would feel angry in this situation.", "It's understandable to be angry in this situation.", "I can see how this situation make you feel angry.","That is normal to feel angry in this situation. Try to take a deep breath for 5 seconds, and let it out slowly."]

let askingIntensity: Array<String> = ["How intense is your happiness right now?","How intense is your sadness right now?", "How intense is your anger right now?"]

let validateIntensity: Array<String> = ["It's good that you can try to figure out how intense your emotion is.","It's understandable to feel that. It’s okay to process your emotion first.","A part of learning to regulate your emotion is to recognize how intense it is. And you're doing great.", "It’s great that you’re able to articulate what you’re feeling and how intense the feeling is.", "A part of regulating your emotions is being able to understand your emotion and feeling okay with having those emotion.", "That is okay. The fact that you confide and write down your emotion here mean you’re able to express yourself.", "Find the right time to express the intensity of your emotions"]

let validateResolution: Array<String> = ["That is great. It takes time to calm yourself down from feeling an intense emotion like that.", "It's a great process to learn to face your emotion.", "I appreciate how you can be in control of your emotion."]

let activityAnger: Array<String> = ["Here is a suggestion when you're feeling angry: \n 1. Slowly repeat a calm word or phrase such as 'relax,' 'take it easy.' Repeat it to yourself while breathing deeply. \n \n 2. Use imagery; visualize a relaxing experience, from either your memory or your imagination. \n \n 3. Non-strenuous, slow yoga-like exercises can relax your muscles and make you feel much calmer."]

let activityHappy: Array<String> = ["Here is a suggestion when you're feeling happy: \n 1. Dont Forget To Smile \n \n 2. Go explore the world with that mood \n \n 3. Dont Forget to Be Grateful \n \n 4. Give Compliments. Dont keep that happiness to yourself \n \n 5. Face stress heads on with that mood"]

class ChatViewModel{
    
    // MARK: - Properties
    
    var messages: Array<Message> = []
    
    var counter: Int = 0
    
    var scoreSentiment: Double = 0
    
    var endFlag = true
    
    var delegate: ChatViewModelDelegate!
    
    var userChoice: String = ""
    
    var emotionEffects: Array<String> = ["💼 Work", "🏫 School", "👫🏻 Relationships", "😕 Insecurities", "Others"]
    
    var emotionString: String = ""
    
    var options2: Array<String> = ["😊 Happy", "😭 Sad", "😡 Angry", "😮 Surprised", "😔 Bad", "🤢 Disgusted", "😱 Fearful"]
    
    var options3: Array<String> = ["A little", "Moderately", "Very", "Extremely"]
    
    var options4: Array<String> = ["Yeah sure", "I don't think I need it now"]
    
    var tempValue: Array<String> = []
    
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
            tempValue.append(userChoice)
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
            tempValue.append(userChoice)
            scoreSentiment = delegate.sentimentAnalyst(message: userChoice)
            delegate.refreshChat()
            counter += 1
            configureChat()
        }else if counter == 6 {
            if scoreSentiment == 0 {
                messages.append(Message(text: "I see. I’d love to hear more.", isBobSender: true))
            } else if scoreSentiment < 0 {
                messages.append(Message(text: negativeResponse[Int.random(in: 0...negativeResponse.count-1)], isBobSender: true))
            } else {
                messages.append(Message(text: positiveResponse[Int.random(in: 0...positiveResponse.count-1)], isBobSender: true))
            }
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
            tempValue.append(userChoice)
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 10 {
            if emotionString.contains("Happy") {
                messages.append(Message(text: validateHappy[Int.random(in: 0...validateHappy.count-1)], isBobSender: true))
            } else if emotionString.contains("Angry") {
                messages.append(Message(text: validateAnger[Int.random(in: 0...validateAnger.count-1)], isBobSender: true))
            }
            delegate.refreshChat()
            counter += 1
            configureChat()
        }else if counter == 11 {
            if emotionString.contains("Happy") {
                messages.append(Message(text: askingIntensity[0], isBobSender: true))
            } else if emotionString.contains("Angry") {
                messages.append(Message(text: askingIntensity[2], isBobSender: true))
            }
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
            tempValue.append(userChoice)
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 14 {
            messages.append(Message(text: validateIntensity[Int.random(in: 0...validateIntensity.count-1)], isBobSender: true))
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
            tempValue.append(userChoice)
            delegate.refreshChat()
            counter += 1
            configureChat()
        }
        else if counter == 18 {
            messages.append(Message(text: validateResolution[Int.random(in: 0...validateResolution.count-1)], isBobSender: true))
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
            if emotionString.contains("Angry") {
                messages.append(Message(text: activityAnger[0], isBobSender: true))
            } else {
                messages.append(Message(text: activityHappy[0], isBobSender: true))
            }
            messages.append(Message(text: "Don't forget to check-in your emotion later", isBobSender: true))
            tempValue.append(activityAnger[0])
            delegate.refreshChat()
            delegate.setParam(message: tempValue)
        }
    }
}
