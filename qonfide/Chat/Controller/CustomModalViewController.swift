//
//  CustomModalViewController.swift
//  HalfScreenPresentation
//
//  Created by Haris Fadhilah on 23/06/2022.
//

import UIKit

//@objc protocol CustomModalViewControllerDelegate: AnyObject
//{
//    @objc optional func userSelect(choice: String?)
//}

protocol CustomModalViewControllerDelegate: AnyObject{
    func userSelect(choice: String)
}

class CustomModalViewController: UIViewController{
    weak var delegate: CustomModalViewControllerDelegate?
    
    private let layoutOptions: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = UIColor(red: 241/255, green: 247/255, blue: 255/255, alpha: 1)
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 12.0
        return stack
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor(red: 241/255, green: 247/255, blue: 255/255, alpha: 1)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    // Constants
    var defaultHeight: CGFloat = 0
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    // Keep current new height, initial is default height
    var currentContainerHeight: CGFloat = 300
    
    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    
    // MARK: - Lifecycle
    
    init(buttonArray: [String]){
        super.init(nibName: nil, bundle: nil)
        for value in buttonArray {
            let button = ButtonOptions(title: value, type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(optionPressed), for: .touchUpInside)
            layoutOptions.addArrangedSubview(button)
        }
        defaultHeight = CGFloat(buttonArray.count * 70)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresentContainer()
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupConstraints() {
        // Add subviews
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(layoutOptions)
        layoutOptions.translatesAutoresizingMaskIntoConstraints = false
        
        // Set static constraints
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // content stackView
            layoutOptions.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            layoutOptions.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            layoutOptions.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            layoutOptions.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
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
        
    // MARK: - Functions
    
    @objc func optionPressed(sender: UIButton)
    {
        delegate?.userSelect(choice: (sender.titleLabel?.text)!)
        dismiss(animated: true)
    }
    
    func animatePresentContainer() {
        // Update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
}
