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
    func refreshChat()
    func setParam(message: [String])
    func sentimentAnalyst(message: String) -> Double
}

let negativeResponse: Array<String> = ["That must be uncomfortable for you.","I'm sorry you are going through this.","That sucks...","This experience must be hard for you.","That sounds challenging.","I'm here to help you with your emotions.","I'm glad that you try to confide here."]

let positiveResponse: Array<String> = ["I'm happy to hear that😊😊", "It must be a pleasant experience for you😄"]

//VALIDATE EMOTIONS

let validateHappy: Array<String> = ["It's great to know you're feeling happy right now.","I'm happy for you.."]

let validateAnger: Array<String> = ["It’s okay to feel angry. Anyone would feel angry in this situation.", "It's understandable to be angry in this situation.", "I can see how this situation make you feel angry.","That is normal to feel angry in this situation. Try to take a deep breath for 5 seconds, and let it out slowly."]

let validateSad: Array<String> = ["It's normal to feel sad in this situation", "It's a hard situation for you. It's okay to be sad.", "I can see how this situation is tough. It's okay to cry."]

let validateSurprise: Array<String> = ["It might feels a little confusing for you."]

let validateBad: Array<String> = ["I can see how this situation might feel stressful for you.", "It's okay to feel tired. It's okay to learn to getting through it one day at a time."]

let validateDisgusted: Array<String> = ["It's okay. Everyone makes mistakes at least once in their life.", "Things might not be going well right now and that is completely okay."]

let validateFearful: Array<String> = ["You might feel weak at the moment and that's okay.", "Your feelings matter, including what you're feeling right now.", "It's okay to feel anxious, but remember that you're more than your accomplishments or failures."]

//VALIDATE INTENSITY

let askingIntensity: [String:String] = ["😊 Happy":"How intense is your happiness right now?",
                                        "😭 Sad":"How intense is your sadness right now?",
                                        "😡 Angry":"How intense is your anger right now?",
                                        "😮 Surprised":"How surprised are you right now?",
                                        "😔 Bad":"How bad are you feeling right now?",
                                        "🤢 Disgusted":"How intense is your disgust right now?",
                                        "😱 Fearful":"How intense is your fear right now?"]

let validateIntensity: Array<String> = ["It's good that you can try to figure out how intense your emotion is.","It's understandable to feel that. It’s okay to process your emotion first.","A part of learning to regulate your emotion is to recognize how intense it is. And you're doing great.", "It’s great that you’re able to articulate what you’re feeling and how intense the feeling is.", "A part of regulating your emotions is being able to understand your emotion and feeling okay with having those emotion.", "That is okay. The fact that you confide and write down your emotion here mean you’re able to express yourself.", "Find the right time to express the intensity of your emotions"]


let validateResolution: Array<String> = ["That is great. It takes time to calm yourself down from feeling an intense emotion like that.", "It's a great process to learn to face your emotion.", "I appreciate how you can be in control of your emotion."]

//ACTIVITY

let activityAnger: Array<String> = ["Here is a suggestion when you're feeling angry: \n 1. Slowly repeat a calm word or phrase such as 'relax,' 'take it easy.' Repeat it to yourself while breathing deeply. \n \n 2. Use imagery; visualize a relaxing experience, from either your memory or your imagination. \n \n 3. Non-strenuous, slow yoga-like exercises can relax your muscles and make you feel much calmer."]

let activityHappy: Array<String> = ["Here is a suggestion when you're feeling happy: \n 1. Dont Forget To Smile \n \n 2. Go explore the world with that mood \n \n 3. Dont Forget to Be Grateful \n \n 4. Give Compliments. Dont keep that happiness to yourself \n \n 5. Face stress heads on with that mood"]

let activitySad: Array<String> = ["Allow yourself to be sad. Denying such feelings may force them underground, where they can do more damage with time. Cry if you feel like it. Notice if you feel relief after the tears stop.", "Think about the context of the sad feelings. Are they related to a loss or an unhappy event? Think about the feelings in a non-judging way and ride the wave of the experience.", "Sadness can result from a change that you didn't expect, or it can signal that you might need to make changes in your life. Emotions are changing and will come and go.", "Listen to your some music, it’s okay if you’d like to listen to sad songs and cry it out. Just remember not to let yourself drown in it for too long. You can always check-in here again to talk it out.", "If you feel like you need to be with anyone, try reaching out to your friend or family you can trust. ", "Try to express your sadness through drawings. It might difficult for you to express your emotion with words, so drawing might help.", "Just pick up whatever you like and do it. From eating a favorite snack, watching a favorite movie or series, go to museum and just enjoy the silence."]

let activityDisgust: Array<String> = ["Make a mental note so you can see the bigger picture when the judgemental thought popup", "Practice deep breathing in moments when you are not feeling disgusted, so your body becomes used to it and can call on this new habit as soon as you sense a need to override the onset of such negativity.", "Take your time to think, don't let your feeling control the way your thinking", "Don't sneer at someone, but instead find a place within yourself where you feel kind, respectful, and caring. You can talk to the closest/trusted person to share what you feel at the time", "Use imagination in a healthy way. Example, Rather than spending time imagining what other people are doing and thinking, become more mindful of your own wants, needs, and feelings", "Look for activities that can foster a sense of empathy. For example, you can try gardening"]

let activitySurprised: Array<String> = ["Surprises and unexpected events are part of life and are unavoidable. Lets learn to accept that", "The key to everything is your attitude. A positive attitude is an asset in unexpected situations.", "Don’t forget to always have an alternate plan, in case the first plans fail", "If what happened is irreversible, what good would you gain by becoming angry, stressed or panicked? You would gain nothing.", "Wait for a few moments, before blurting out when confronting unexpected or unpleasant turns of fate. Before getting angry or panicking, look at what happened and assimilate the news"]

let activityBad: Array<String> = ["When you feel down because of mental pressure, try to keep doing activities that can calm you down. These activities can range from reading a book, watching a movie or to a few days off for a vacation.", "Meet your friends or family that can give you support. Talk with them about what your feels", "Eat your favourite snack or food to reduce bad emotion. But you have to control what you eat.", "You can do some exercise such as jogging. This can help you to reduce your bad emotion and make you healthy.", "Don't forget to take a rest or sleep. Research says that sleep is effective ways to regulate emotion and make you more focus.", "Try to listen to your favourite music. Fun fact: the body's internal rhythm turns out to follow the rhythm of the music you are listening to."]

let activityFear: Array<String> = ["-> Take time out \n \n It's impossible to think clearly when you're flooded with fear or anxiety. The first thing to do is take time out so you can physically calm down. Distract yourself from the worry for 15 minute by walking around the block, making a cup of tea or having a bath.", "-> Breathe through panic \n \n If you start to get a faster heartbeat or sweating palms, the best thing is not to fight it. Stay where you are and simply feel the panic without trying to distract yourself. \n \n Place the palm of your hand on your stomach and breathe slowly and deeply. The goal is to help the mind get used to coping with panic, which takes the fear of fear away.", "-> Face your fears \n \n Avoiding fears only makes them scarier. Whatever your fear, if you face it, it should start to fade. If you panic one day getting into a lift, for example, it's best to get back into a lift the next day."]

class ChatViewModel{
    
    // MARK: - Properties
    
    var messages: Array<Message> = []
    
    var counter: Int = 0
    
    var scoreSentiment: Double = 0
    
    var endFlag = true
    
    var delegate: ChatViewModelDelegate!
        
    let options1: Array<String> = ["💼 Work", "🏫 School", "👫🏻 Relationships", "😕 Insecurities", "Others"]
    
    let options2: Array<String> = ["😊 Happy", "😭 Sad", "😡 Angry", "😮 Surprised", "😔 Bad", "🤢 Disgusted", "😱 Fearful"]
    
    let options3: Array<String> = ["A little", "Moderately", "Very", "Extremely"]
    
    let options4: Array<String> = ["Yeah sure", "I don't think I need it now"]
    
    var emotionString: String = ""
    
    var userChoice: String = ""
    
    var tempValue: Array<String> = []
    
    func configureChat(){
        print(userChoice)
        switch counter {
        case 0:
            messages.append(Message(text: "Hey, I'm Bob. I'm here to help you with your emotions. Can you first tell me what is affecting your emotion?", isBobSender: true))
            counter += 1
            configureChat()
        case 1:
            delegate.presentChoiceModal(buttons: options1)
            counter += 1
        case 2:
            if userChoice.contains("Others") {
                delegate.presentTextModal()
            } else {
                messages.append(Message(text: "Hey, Bob. It's mostly because of " + userChoice, isBobSender: false))
                tempValue.append(userChoice)
                delegate.refreshChat()
                counter += 1
                configureChat()
            }
        case 3:
            messages.append(Message(text: "Can you write how and why " + userChoice + " affects you?", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 4:
            delegate.presentTextModal()
            counter += 1
        case 5:
            messages.append(Message(text: userChoice, isBobSender: false))
            tempValue.append(userChoice)
            scoreSentiment = delegate.sentimentAnalyst(message: userChoice)
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 6:
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
        case 7:
            messages.append(Message(text: "How did this situation make you feel?", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 8:
            delegate.presentChoiceModal(buttons: options2)
            counter += 1
        case 9:
            messages.append(Message(text: "It mostly makes me feel " + userChoice, isBobSender: false))
            tempValue.append(userChoice)
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 10:
            if emotionString.contains("Happy") {
                messages.append(Message(text: validateHappy[Int.random(in: 0...validateHappy.count-1)], isBobSender: true))
            } else if emotionString.contains("Angry") {
                messages.append(Message(text: validateAnger[Int.random(in: 0...validateAnger.count-1)], isBobSender: true))
            }else if emotionString.contains("Sad"){
                messages.append(Message(text: validateSad[Int.random(in: 0...validateSad.count-1)], isBobSender: true))
            }else if emotionString.contains("Bad"){
                messages.append(Message(text: validateBad[Int.random(in: 0...validateBad.count-1)], isBobSender: true))
            }else if emotionString.contains("Surprised"){
                messages.append(Message(text: validateSurprise[Int.random(in: 0...validateSurprise.count-1)], isBobSender: true))
            }else if emotionString.contains("Disgusted"){
                messages.append(Message(text: validateDisgusted[Int.random(in: 0...validateDisgusted.count-1)], isBobSender: true))
            }else if emotionString.contains("Fearful"){
                messages.append(Message(text: validateFearful[Int.random(in: 0...validateFearful.count-1)], isBobSender: true))
            }
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 11:
            messages.append(Message(text: askingIntensity[emotionString]!, isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 12:
            delegate.presentChoiceModal(buttons: options3)
            counter += 1
        case 13:
            messages.append(Message(text: "I Feel " + userChoice + " " + emotionString, isBobSender: false))
            tempValue.append(userChoice)
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 14:
            messages.append(Message(text: validateIntensity[Int.random(in: 0...validateIntensity.count-1)], isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 15:
            messages.append(Message(text: "Have you tried to do something to make yourself feel better?", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 16:
            delegate.presentTextModal()
            counter += 1
        case 17:
            messages.append(Message(text: userChoice, isBobSender: false))
            tempValue.append(userChoice)
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 18:
            messages.append(Message(text: validateResolution[Int.random(in: 0...validateResolution.count-1)], isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 19:
            messages.append(Message(text: "Would you want to receive an activity suggestion that might help you?", isBobSender: true))
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 20:
            delegate.presentChoiceModal(buttons: options4)
            counter += 1
        case 21:
            messages.append(Message(text: userChoice, isBobSender: false))
            delegate.refreshChat()
            counter += 1
            configureChat()
        case 22:
            if userChoice == "Yeah sure" {
                if emotionString.contains("Happy") {
                    messages.append(Message(text: activityHappy[Int.random(in: 0...activityHappy.count-1)], isBobSender: true))
                } else if emotionString.contains("Angry") {
                    messages.append(Message(text: activityAnger[Int.random(in: 0...activityAnger.count-1)], isBobSender: true))
                }else if emotionString.contains("Sad"){
                    messages.append(Message(text: activitySad[Int.random(in: 0...activitySad.count-1)], isBobSender: true))
                }else if emotionString.contains("Bad"){
                    messages.append(Message(text: activityBad[Int.random(in: 0...activityBad.count-1)], isBobSender: true))
                }else if emotionString.contains("Surprised"){
                    messages.append(Message(text: activitySurprised[Int.random(in: 0...activitySurprised.count-1)], isBobSender: true))
                }else if emotionString.contains("Disgusted"){
                    messages.append(Message(text: activityDisgust[Int.random(in: 0...activityDisgust.count-1)], isBobSender: true))
                }else if emotionString.contains("Fearful"){
                    messages.append(Message(text: activityFear[Int.random(in: 0...activityFear.count-1)], isBobSender: true))
                }
            }
            messages.append(Message(text: "Don't forget to check-in your emotion later", isBobSender: true))
            tempValue.append(messages[messages.count-2].text)
            delegate.refreshChat()
            delegate.setParam(message: tempValue)
        default:
            print("ERROR: COUNTER NOT FOUND")
        }
    }
}
