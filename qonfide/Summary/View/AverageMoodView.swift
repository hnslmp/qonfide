//
//  AverageMoodView.swift
//  qonfide
//
//  Created by Hansel Matthew on 20/06/22.
//

import UIKit

struct moodStruct {
    let mood: String
    let count: Int
}

class AverageMoodView: UIView{
    
    
    // MARK: - Properties
    private let moodTitle: UILabel = {
        
        let emotions: [String] = AppHelper.appInputs.map{$0.answer3}
        var emotionCounts: [String: Int] = [:]
        for item in emotions {
            emotionCounts[item] = (emotionCounts[item] ?? 0) + 1
        }
        let maxEmoitons = emotionCounts.max { a, b in a.value < b.value }
        let averageMood = maxEmoitons?.key ?? ""
        
        let label = UILabel()
        let textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        let attributedTitle = NSMutableAttributedString(string: "Your average mood is ", attributes: [.foregroundColor: textColor, .font: UIFont.systemFont(ofSize: 20)])
        attributedTitle.append(NSAttributedString(string: averageMood, attributes: [.foregroundColor: textColor, .font: UIFont.boldSystemFont(ofSize: 20)]))
        label.attributedText = attributedTitle
        
        return label
    }()
    
    private let moodLine: UIImageView = {
        let view = UIImageView(image: UIImage(named: "cellLine"))
        return view
    }()
    
    private let moodBody: UILabel = {
        let label = UILabel()
        label.textColor =  UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        label.text = "Throughout the week, you feel"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let moodStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        
        let moods = [moodStruct(mood: "Happy", count: 4), moodStruct(mood: "Sadness", count: 2)]
        let emotions: [String] = AppHelper.appInputs.map{$0.answer3}
        var emotionCounts: [String: Int] = [:]
        for item in emotions {
            emotionCounts[item] = (emotionCounts[item] ?? 0) + 1
        }
        let emotionsSorted = emotionCounts.sorted{ $0.value > $1.value }
        for i in 0...2{
            stack.addArrangedSubview(MoodCellView(mood: emotionsSorted[i].key, count: emotionsSorted[i].value))
        }
        
        return stack
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 241/255, green: 247/255, blue: 255/255, alpha: 1)
        layer.cornerRadius = 10
        heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        addSubview(moodTitle)
        moodTitle.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 24)
        
        addSubview(moodLine)
        moodLine.anchor(top: moodTitle.bottomAnchor, paddingTop: 12)
        moodLine.centerX(inView: self)
        
        addSubview(moodBody)
        moodBody.anchor(top: moodLine.bottomAnchor,left:leftAnchor, paddingTop: 12, paddingLeft: 24)
        
        addSubview(moodStack)
        moodStack.anchor(top: moodBody.bottomAnchor,left:leftAnchor, paddingTop: 12, paddingLeft: 24)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}
