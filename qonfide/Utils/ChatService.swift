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
    
    static func fetchMessages() async throws -> [Input]{
        do {
            
            var Inputs: Array<Input> = []
            
            guard let currentUid = Auth.auth().currentUser?.uid else {
                print("DEBUG: returned from guard")
                return []}
            
            let query = try await COLLECTION_USERS.document(currentUid).collection("messages").getDocuments()
            
            let queryDoc = query.documents
            
            for i in 0..<queryDoc.count {
//                print("DEBUG: Getting querydocs")
                let snapshot = queryDoc[i]
                let messageSnapshot = snapshot.data()
                let message = Input(
                    answer1: messageSnapshot["answer1"] as! String,
                    answer2: messageSnapshot["answer2"] as! String,
                    answer3: messageSnapshot["answer3"] as! String,
                    answer4: messageSnapshot["answer4"] as! String,
                    answer5: messageSnapshot["answer5"] as! String,
                    answer6: messageSnapshot["answer6"] as! String
                )
//                print("DEBUG: Printing message \(message)")
               
                Inputs.append(message)
                print(message)
            }
            return Inputs
        }
        
        
//        var Inputs: Array<Input> = []
//
//        guard let currentUid = Auth.auth().currentUser?.uid else {
//            print("DEBUG: Guard fetch messages returned")
//            return []}
//
//        COLLECTION_USERS.document(currentUid).collection("messages").getDocuments { querySnapshot, err in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("DEBUG: Getting documents")
//                    let currEntry = Input(
//                        answer1: document.get("answer1")! as! String,
//                        answer2: document.get("answer2")! as! String,
//                        answer3: document.get("answer3")! as! String,
//                        answer4: document.get("answer4")! as! String,
//                        answer5: document.get("answer5")! as! String,
//                        answer6: document.get("answer6")! as! String
//                    )
//                    Inputs.append(currEntry)
//                }
//            }
//            print("DEBUG: Inputs array \(Inputs)")
////            return Inputs
//        }
//
//        print("DEBUG: Retunred from functions")
//
//
//        return Inputs
    }
}
