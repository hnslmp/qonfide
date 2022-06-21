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

class AverageMoodView: UIStackView{
    
    private let moodTitle: UILabel = {
        
        //TODO: Change into using dynamic data
        let averageMood = "Happy"
        
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
//        let view = UIView()
//        let width = 2
//        view.frame = CGRect(x: 0, y: 0, width: 300, height: width)
//        let line = CALayer()
//        line.backgroundColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1).cgColor
//        line.frame = CGRect(x: 0, y: 0, width: Int(view.frame.width), height: width)
//        view.layer.addSublayer(line)
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
        
        moods.forEach { moodStruct in
            stack.addArrangedSubview(MoodCellView(mood: moodStruct.mood, count: moodStruct.count))
        }
        
        return stack
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 241/255, green: 247/255, blue: 255/255, alpha: 1)
        layer.cornerRadius = 10
        heightAnchor.constraint(equalToConstant: 120).isActive = true
        axis = .vertical
        alignment = .center
        distribution = .fillProportionally
        
        [moodTitle, moodLine, moodBody, moodStack].forEach {view in addArrangedSubview(view)}
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}
