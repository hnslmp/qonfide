//
//  SummaryViewModel.swift
//  qonfide
//
//  Created by Hansel Matthew on 18/06/22.
//

import UIKit

class SummaryViewModel {
    
    func configureChartData() -> [Int] {
        
        var dataSource = [0,0,0,0,0,0,0]
        var emotionCounts: [String: Int] = [:]
        
        let emotions: [String] = AppHelper.appInputs.map{$0.answer3}
        for item in emotions {
            emotionCounts[item] = (emotionCounts[item] ?? 0) + 1
        }
        let happyCount = emotionCounts["😊 Happy"]
        let sadCount = emotionCounts["😭 Sad"]
        let angryCount = emotionCounts["😡 Angry"]
        let suprisedCount = emotionCounts["😮 Surprised"]
        let disgustedCount = emotionCounts["🤢 Disgusted"]
        let fearfulCount = emotionCounts["😱 Fearful"]
        let badCount = emotionCounts["😔 Bad"]
                
        dataSource[0] = happyCount ?? 0
        dataSource[1] = sadCount ?? 0
        dataSource[2] = angryCount ?? 0
        dataSource[3] = suprisedCount ?? 0
        dataSource[4] = disgustedCount ?? 0
        dataSource[5] = fearfulCount ?? 0
        dataSource[6] = badCount ?? 0
        
        return dataSource
    }
    
    func getAverageMood() -> String {
        let emotions: [String] = AppHelper.appInputs.map{$0.answer3}
        var emotionCounts: [String: Int] = [:]
        for item in emotions {
           emotionCounts[item] = (emotionCounts[item] ?? 0) + 1
        }
        let maxEmotions = emotionCounts.max { a, b in a.value < b.value }
        let averageMood = maxEmotions?.key ?? ""
        return averageMood
    }
    
}
