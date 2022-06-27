//
//  MessageCell.swift
//  qonfide
//
//  Created by Hansel Matthew on 16/06/22.
//

import UIKit

class MessageCell: UICollectionViewCell{
    
    // MARK: - Properties
    
    var message:Message? {
        didSet { configure() }
    }
    
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "bobChatImage")
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.textColor = UIColor(red: 53/255, green: 74/255, blue: 166/255, alpha: 1)
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemCyan
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect){
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor , paddingLeft: 8, paddingBottom: -4)
        profileImageView.setDimensions(height: 32, width: 32)
        profileImageView.layer.cornerRadius = 32/2
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor, bottom: bottomAnchor)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        bubbleLeftAnchor.isActive = false
        
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        bubbleRightAnchor.isActive = false

        bubbleContainer.addSubview(textView)
        textView.anchor(top:bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 4,paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let message = message else { return  }
        let viewModel = MessageViewModel(message: message)
        
        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.text = message.text
        
        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive
        
        profileImageView.isHidden = viewModel.shouldHideProfileImage
    }
    
}
