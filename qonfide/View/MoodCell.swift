//
//  MoodCell.swift
//  qonfide
//
//  Created by Hansel Matthew on 20/06/22.
//

import UIKit

class MoodCellView: UIStackView{
    
    init(mood: String, count: Int){
        super.init(frame: .zero)
                
        axis = .horizontal
        distribution = .equalSpacing
        
        let countLabel = UILabel()
        countLabel.text = " \(String(count)) "
        countLabel.font = .boldSystemFont(ofSize: 20)
        countLabel.textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        
        let moodLabel = MoodCell(mood: mood)
        [countLabel, moodLabel].forEach {view in addArrangedSubview(view)}
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MoodCell: UILabel{
    
    init(mood: String){
        super.init(frame: .zero)
        backgroundColor = .white
                
        layer.masksToBounds = true
        layer.cornerRadius = 13
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1).cgColor
        
        font = .systemFont(ofSize: 16)
        textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        text = " 🙂 \(mood) "
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
