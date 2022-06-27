//
//  timePickerView.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 19/06/22.
//

import UIKit

protocol SelectTimeReminderDelegate {
    func ChangeTimeReminderDelegate(date: Date)
}

// MARK: -- BELOM DI MODIF

class ModalChooseReminder: UIViewController {

    var parentButton:String?
        
        // define lazy views
        lazy var doneButton: UIButton = {
            let done = UIButton()
            done.setTitle("Done", for: .normal)
            done.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
            done.setTitleColor(UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 100), for: .normal)
            done.addTarget(self, action: #selector(handleCloseAction), for: .touchUpInside)
            done.backgroundColor = .white
            
            return done
        }()
    
        lazy var textLabel: UILabel = {
            let labelText = UILabel()
            labelText.text = "Select Time"
            labelText.textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 100)
            labelText.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
            
            return labelText
        }()
    
        lazy var inputField: UITextField = {
            let inputText = UITextField()
            inputText.textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 100)
            inputText.placeholder = "Pick a time"
            inputText.textAlignment = .center
            inputText.inputView = timePicker
            inputText.inputAccessoryView = createToolbar()
            
            return inputText
        }()
    
//    MARK: --CANCEL BUTTON HAPUS
        lazy var cancelButton: UIButton = {
            let cancel = UIButton()
            cancel.setTitle("Cancel", for: .normal)
            cancel.addTarget(self, action: #selector(handleCancelAction), for: .touchUpInside)
            cancel.setTitleColor(UIColor(named: "purpleHeader"), for: .normal)
            return cancel
        }()
        
        lazy var timePicker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.datePickerMode = .time
            picker.preferredDatePickerStyle = .wheels
//            picker.addTarget(self, action: #selector(respondToChanges), for: .valueChanged)
            return picker
        }()
        
        lazy var buttonStackView: UIStackView = {
            let spacer = UIView()
            let stckView = UIStackView(arrangedSubviews: [textLabel,spacer,doneButton])
            stckView.distribution = .fillEqually
            stckView.axis = .horizontal
            return stckView
        }()
        
        lazy var contentStackView: UIStackView = {
            let spacer = UIView()
            let stackView = UIStackView(arrangedSubviews: [buttonStackView, spacer,inputField, spacer])
            stackView.axis = .vertical
            stackView.spacing = 12.0
            return stackView
        }()
        
        lazy var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 16
            view.clipsToBounds = true
            return view
        }()
        
        let maxDimmedAlpha: CGFloat = 0.6
        lazy var dimmedView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            view.alpha = maxDimmedAlpha
            return view
        }()
        
        // Constants
        let defaultHeight: CGFloat = 350
        let dismissibleHeight: CGFloat = 200
        let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
        // keep current new height, initial is default height
        var currentContainerHeight: CGFloat = 300
        
        // Dynamic container constraint
        var containerViewHeightConstraint: NSLayoutConstraint?
        var containerViewBottomConstraint: NSLayoutConstraint?
        
    var selectTimeDelegate:SelectTimeReminderDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        // tap gesture on dimmed view to dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
//        print(parentButton ?? "Parent Button Empty")
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pickerClosed"), object: nil)
    }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    @objc func handleCancelAction(){
        cancelDismissView()
    }
    
//    MARK: -- GA FAHAM FUNGSINYA
    @objc func respondToChanges(date: Date) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "HH:MM a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        self.inputField.text = dateFormatter.string(from: date)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
//    MARK: --TOOLBAR
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: true)
        
        return toolbar
    }
    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        let date = timePicker.date
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        self.inputField.text = dateFormatter.string(from: timePicker.date)
        selectTimeDelegate.ChangeTimeReminderDelegate(date: date)
        self.view.endEditing(true)
    }
    
    func setupView() {
        view.backgroundColor = .clear
    }
    
    func setupConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set static constraints
        NSLayoutConstraint.activate([
            // set dimmedView edges to superview
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // set container static constraint (trailing & leading)
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // content stackView
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
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
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func animateDismissView() {
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
//            MARK: -- FOR WUT?
//            print(self.timePicker.countDownDuration)
//            if self.parentButton == "work"{
//                UserDefaultManager.shared.defaults.set(self.timePicker.countDownDuration, forKey: "workSession")
//            } else if self.parentButton == "rest"{
//                UserDefaultManager.shared.defaults.set(self.timePicker.countDownDuration, forKey: "restSession")
//            }
//            SelectTimeReminderDelegate.ChangeTimeQuoteDelegate(date: <#T##Date#>)
            // once done, dismiss without animation
            self.dismiss(animated: false, completion: nil)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    func cancelDismissView() {
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false, completion: nil)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
}
