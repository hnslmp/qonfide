//
//  SettingsViewController.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 17/06/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import UserNotifications

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signOut: UIButton!
    @IBOutlet weak var deleteAccount: UIButton!
    @IBOutlet weak var selectPhoto: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
//    --MARK: Data Dummy
    
    var userData:Users = Users(username: "John Doe", password: "mbuhkeder", email: "johndoe123@gmail.com", profilePicture: (UIImage(named: "qonfide logo"))!)
    var textInCells = ["", "Check-In Reminder", "Daily Quotes Reminder"]
    let notificationCenter = UNUserNotificationCenter.current()
    private var profileImage: UIImage?
    
//    To set default value timer
    var dateComp = DateComponents()
    var dateReminder:Date = Date()
    var dateQuotes:Date = Date()
    let dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib.init(nibName: "ChangePasswordCell", bundle: nil), forCellReuseIdentifier: ChangePasswordCell.identifier)
        self.tableView.register(UINib.init(nibName: "ReminderCell", bundle: nil), forCellReuseIdentifier: ReminderCell.identifier)
        
        selectPhoto.setImage(userData.profilePicture.withRenderingMode(.alwaysOriginal), for: .normal)
//        selectPhoto.imageView?.layer.cornerRadius = selectPhoto.frame.size.width/2
        selectPhoto.layer.cornerRadius = 50
        selectPhoto.clipsToBounds = true
        selectPhoto.contentMode = .center
        selectPhoto.imageView?.contentMode = .scaleAspectFit
        selectPhoto.imageView?.clipsToBounds = true
        selectPhoto.imageView?.layer.masksToBounds = true
        selectPhoto.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        
        usernameField.text = userData.username
        usernameField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        usernameField.addTarget(self, action: #selector(DidChangeNickName), for: .editingChanged)
        emailField.text = userData.email
        emailField.font = UIFont.systemFont(ofSize: 16)
        emailField.addTarget(self, action: #selector(DidChangeEmail), for: .editingChanged)
        
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        dateComp.calendar = Calendar.current
        dateComp.hour = 12
        dateComp.minute = 0
        
        dateReminder = dateComp.date!
        dateQuotes = dateComp.date!
        
        signOut.layer.cornerRadius = 10
        deleteAccount.layer.cornerRadius = 10
        
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
            (permissionGranted, error) in
            if !permissionGranted {
                print("Permission Denied")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        doSignOut()
    }
    
    @IBAction func deleteAccTapped(_ sender: Any) {
        doDeleteAccount()
    }
    
    @objc func handleSelectPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true,completion: nil)
    }
    
    @objc func DidChangeNickName() {
        if usernameField.text != "" {
            userData.username = usernameField.text!
            usernameField.text = userData.username
        } else {
            usernameField.text = userData.username
        }
    }
    
    @objc func DidChangeEmail() {
        if emailField.text != "" {
            userData.email = emailField.text!
            emailField.text = userData.email
        } else {
            emailField.text = userData.email
        }
    }
    
    func doSignOut() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.pushViewController(LoginPageController(), animated: true)
        } catch let signOutError as NSError {
            print("Error sign out: \(signOutError)")
        }
    }
    
    func doDeleteAccount() {
        let user = Auth.auth().currentUser
        
        user?.delete() { error in
            if let error = error {
//                if error occur while deleting account user
                print(error)
                
            } else {
                self.navigationController?.pushViewController(LoginPageController(), animated: true)
            }
        }
    }
    
}

// MARK: - IMAGE PICKER EXT
extension SettingsViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        selectPhoto.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectPhoto.imageView?.contentMode = .scaleAspectFit
        selectPhoto.contentMode = .center
        selectPhoto.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        selectPhoto.layer.borderWidth = 1
//        selectPhoto.layer.cornerRadius = selectPhoto.layer.bounds.width * 0.5
//        selectPhoto.clipsToBounds = true
        userData.profilePicture = profileImage!
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView EXT
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource, SelectTimeReminderDelegate, SelectTimeQuotesDelegate{
    
    func ChangeTimeQuotesDelegate(date: Date) {
        self.dateQuotes = date
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func ChangeTimeReminderDelegate(date: Date) {
        self.dateReminder = date
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChangePasswordCell.identifier, for: indexPath) as! ChangePasswordCell
            
            cell.view.layer.cornerRadius = 10
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.section == 1 {
//            MARK: Reminder Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.identifier, for: indexPath) as! ReminderCell
            
            cell.view.layer.cornerRadius = 10
            cell.selectionStyle = .none
            
            cell.labelTxt.text = dateFormatter.string(from: dateReminder)
            cell.labelTxt.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            
            cell.switchBtn.setOn(false, animated: true)
            cell.switchBtn.tag = indexPath.section
            cell.switchBtn.addTarget(self, action: #selector(switchChangeReminder), for: .valueChanged)
            
            return cell
        } else {
//            MARK: Daily Quotes Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.identifier, for: indexPath) as! ReminderCell
            
            cell.view.layer.cornerRadius = 10
            cell.selectionStyle = .none
            
            cell.labelTxt.text = dateFormatter.string(from: dateQuotes)
            cell.labelTxt.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            
            cell.switchBtn.setOn(false, animated: true)
            cell.switchBtn.tag = indexPath.section
            cell.switchBtn.addTarget(self, action: #selector(switchChangeQuotes), for: .valueChanged)
            
            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0{
            return 30.0
        }
        return 0
    }
    
//    MARK: -- Title header

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 1 {
//            return "Check-In Reminder"
//        }
//        else if section == 2 {
//            return "Daily Quotes Reminder"
//        }
//        else {
//            return ""
//        }
//    }
    
//     MARK: -- Custom title header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        view.backgroundColor = .white
        
        let labelTxt = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 20))
        
        labelTxt.textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 100)
        labelTxt.text = textInCells[section]
        labelTxt.font = UIFont.boldSystemFont(ofSize: 17)
        view.addSubview(labelTxt)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let storyboard = UIStoryboard(name: "Settings", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ChangePasswordView")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.section == 1 {
            let vc = ModalChooseReminder()
            vc.selectTimeDelegate = self
            vc.inputField.text = self.dateFormatter.string(from: dateReminder)
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        else {
            let vc = ModalChooseQuotes()
            vc.selectTimeDelegate = self
            vc.inputField.text = self.dateFormatter.string(from: dateQuotes)
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
    }
    
//    MARK: -- switchEnableQuote
    @objc func switchChangeQuotes (_ sender: UISwitch!) {
        if sender.isOn {
            notificationCenter.getNotificationSettings { (settings) in
                DispatchQueue.main.async {
                    let title = "Quotes Of the Day"
                    let message = "Let by gone be by gone"
                    
                    if settings.authorizationStatus == .authorized {
                        let content = UNMutableNotificationContent()
                        content.title = title
                        content.body = message
                        let dateComp = Calendar.current.dateComponents([.hour, .minute], from: self.dateQuotes)
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        self.notificationCenter.add(request) { (error) in
                            if error != nil {
                                print("Error " + error.debugDescription)
                                return
                            }
                        }
                    }
                    else {
                        sender.setOn(false, animated: true)
                        let ac = UIAlertController(title: "Enable Notification?", message: "To use this feature you must enable notifications in settings", preferredStyle: .alert)
                        
                        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(_) in
                        }))
                        
                        let goToSettings = UIAlertAction(title: "Settings", style: .default) { (_) in
                            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                                return
                            }
                            
                            if UIApplication.shared.canOpenURL(settingsURL) {
                                UIApplication.shared.open(settingsURL) { (_) in  }
                            }
                        }
                        ac.addAction(goToSettings)
                        self.present(ac, animated: true)
                    }
                }
            }
        }
        else {
            cancelNotification()
        }
    }
    
//    MARK: -- switchEnableReminder
    @objc func switchChangeReminder (_ sender:UISwitch!) {
        if sender.isOn {
            notificationCenter.getNotificationSettings { (settings) in
                DispatchQueue.main.async {
                    let title = "Hi, Users!"
                    let message = "How are you today?"
                    
                    if settings.authorizationStatus == .authorized {
                        sender.setOn(true, animated: true)
                        let content = UNMutableNotificationContent()
                        content.title = title
                        content.body = message
                        let dateComp = Calendar.current.dateComponents([.hour, .minute], from: self.dateReminder)
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        self.notificationCenter.add(request) { (error) in
                            if error != nil {
                                print("Error " + error.debugDescription)
                                return
                            }
                        }
                    }
                    else {
                        sender.setOn(false, animated: true)
                        let ac = UIAlertController(title: "Enable Notification?", message: "To use this feature you must enable notifications in settings", preferredStyle: .alert)
                        
                        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(_) in
                        }))
                        
                        let goToSettings = UIAlertAction(title: "Settings", style: .default) { (_) in
                            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                                return
                            }
                            
                            if UIApplication.shared.canOpenURL(settingsURL) {
                                UIApplication.shared.open(settingsURL) { (_) in  }
                            }
                        }
                        ac.addAction(goToSettings)
                        self.present(ac, animated: true)
                    }
                }
            }
        }
    }
    
    func cancelNotification() {
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.removeAllDeliveredNotifications()
    }
    
}

