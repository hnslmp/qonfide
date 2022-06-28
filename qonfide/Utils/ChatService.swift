//
//  ChatService.swift
//  qonfide
//
//  Created by Haris Fadhilah on 27/06/22.
//

import Foundation
import Firebase

let keya: Array<String> = ["answer1","answer2","answer3","answer4","answer5","answer6","timestamp"]

var listMessage: Array<Any> = []

//struct ChatService {
//
//    func uploadMessage(_ param: [Any]) {
//
////        for value in param {
////            listMessage.insert(1, at: 0)
////        }
//
//        guard let currentUid = Auth.auth().currentUser?.uid else { return }
//        print("current user \(currentUid)")
//
//
//    }
//}

class ChatServiceClass {
    
    static func processData(_ param: [String]) {
        let time = Timestamp(date:Date())
        
        for value in param {
            listMessage.append(value)
        }
        
        listMessage.append(time)
        
        let data = Dictionary(uniqueKeysWithValues: zip(keya,listMessage))
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        print("DEBUG: CURRENT USER " + currentUid)
        
        COLLECTION_USERS.document(currentUid).collection("messages").document().setData(data)
    }
    
}
