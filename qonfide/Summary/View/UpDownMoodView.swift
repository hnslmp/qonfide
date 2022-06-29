//
//  UpDownMoodView.swift
//  qonfide
//
//  Created by Hansel Matthew on 21/06/22.
//

import UIKit

class UpDownMoodView: UIView {
    
    // MARK: - Properties
    
    private let upMoodBody: UILabel = {
        let label = UILabel()
        label.textColor =  UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        label.text = "What brings you up this week"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let downMoodBody: UILabel = {
        let label = UILabel()
        label.textColor =  UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        label.text = "What brings you down this week"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let moodLine: UIImageView = {
        let view = UIImageView(image: UIImage(named: "cellLine"))
        return view
    }()
    
    private let upMoodStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        
        let inputs = AppHelper.appInputs
        let filteredHappy = inputs.filter { $0.answer3 == "😊 Happy" }
        let upMoodReason = filteredHappy.map { $0.answer1 }
        let upMoodReasonUniqued = upMoodReason.uniqued()
        
        upMoodReasonUniqued.forEach { reason in
            stack.addArrangedSubview(ReasonCell(reason: reason))
        }
                
        return stack
    }()
    
    private let downMoodStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        
        let inputs = AppHelper.appInputs
        let filteredUnhappy = inputs.filter { $0.answer3 != "😊 Happy"}
        let downMoodReason = filteredUnhappy.map{ $0.answer1 }
        let downMoodReasonUniqued = downMoodReason.uniqued()
        
        downMoodReasonUniqued.forEach { reason in
            stack.addArrangedSubview(ReasonCell(reason: reason))
        }
                
        return stack
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 241/255, green: 247/255, blue: 255/255, alpha: 1)
        layer.cornerRadius = 10
        heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        addSubview(upMoodBody)
        upMoodBody.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 24)
        
        addSubview(upMoodStack)
        upMoodStack.anchor(top: upMoodBody.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 24)
        
        addSubview(moodLine)
        moodLine.anchor(top: upMoodStack.bottomAnchor, paddingTop: 12)
        moodLine.centerX(inView: self)
        
        addSubview(downMoodBody)
        downMoodBody.anchor(top: moodLine.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 24)
        
        addSubview(downMoodStack)
        downMoodStack.anchor(top: downMoodBody.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 24)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
