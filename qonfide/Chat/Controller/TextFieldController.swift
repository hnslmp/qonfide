//
//  TextFieldController.swift
//  qonfide
//
//  Created by Haris Fadhilah on 23/06/22.
//

import UIKit

protocol TextFieldControllerDelegate: AnyObject {
    func userInput(_ inputView: TextFieldController,wantsToSend input: String)
}

class TextFieldController: UIViewController {
    
    weak var delegate: TextFieldControllerDelegate?
    
    //COMPONENT TEXT VIEW
    
    private lazy var messageInputTextView: UITextView = {
        let tv = UITextView()
        tv.autocorrectionType = .no
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = true
        tv.backgroundColor = UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 0.2)
        tv.layer.cornerRadius = 8
        return tv
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Type your answer here"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        
        return label
    }()
    
    //CONTAINER TEXT VIEW
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor(red: 241/255, green: 247/255, blue: 255/255, alpha: 1)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var containerTextView: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor(red: 241/255, green: 247/255, blue: 255/255, alpha: 1)
        view.autoresizingMask = .flexibleHeight
        
        view.addSubview(sendButton)
        sendButton.anchor(top: view.topAnchor, right: view.rightAnchor,paddingTop: 25,paddingRight: 8)
        sendButton.setDimensions(height: 50,width: 50)
        
        view.addSubview(messageInputTextView)
        messageInputTextView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,right: sendButton.leftAnchor,paddingTop: 12,paddingLeft: 4,paddingBottom: 8,paddingRight: 8)
        
        view.addSubview(placeholderLabel)
        placeholderLabel.anchor(left: messageInputTextView.leftAnchor, paddingLeft: 4)
        placeholderLabel.centerY(inView: messageInputTextView)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
        
        return view
    }()
    
    // Constants
    let defaultHeight: CGFloat = 150
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    // keep current new height, initial is default height
    var currentContainerHeight: CGFloat = 300
    
    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupPanGesture()
    }
    
    @objc func handleCloseAction() {
//        animateDismissView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        animateShowDimmedView()
        animatePresentContainer()
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupConstraints() {
        // Add subviews
//        view.addSubview(dimmedView)
        view.addSubview(containerView)
//        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(containerTextView)
        containerTextView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set static constraints
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // content stackView
            containerTextView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            containerTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            containerTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            containerTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
        ])
        
        // Set dynamic constraints
        // First, set container to default height
        // after panning, the height can expand
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        // By setting the height to default height, the container will be hide below the bottom anchor view
        // Later, will bring it up by set it to 0
        // set the constant to default height to bring it down again
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    func setupPanGesture() {
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    // MARK: Pan gesture handler
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // Drag to top will be minus value and vice versa
        print("Pan gesture y offset: \(translation.y)")
        
        // Get drag direction
        let isDraggingDown = translation.y > 0
        print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
        
        // New height is based on value of dragging plus current container height
        let newHeight = currentContainerHeight - translation.y
        
        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < maximumContainerHeight {
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = newHeight
                // refresh layout
                view.layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < dismissibleHeight {
                print("dd")
            }
            else if newHeight < defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    
    
    // MARK: FUNCTION
        
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            // Update container height
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height
    }
    
    // MARK: Present and dismiss animation
    func animatePresentContainer() {
        // update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Selector TEXT VIEW
    
    @objc func handleTextInputChange(){
        placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
    }
        
    @objc func handleSendMessage() {
        guard let message = messageInputTextView.text else { return  }
        print("DEBUG: \(message)")
        delegate?.userInput(self,wantsToSend: message)
    }
    
    // MARK: - Helpers
    
    func clearMessageText() {
        messageInputTextView.text = nil
        placeholderLabel.isHidden = false
    }

}
