//
//  HomeController.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 23/06/22.
//

import UIKit
import Firebase
import SwiftUI
import CoreMIDI

class HomeController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var greetTxt: UILabel!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var quoteTxt: UILabel!
    @IBOutlet weak var authorTxt: UILabel!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var changeDateBtn: UIButton!
    @IBOutlet weak var viewQuotes: UIView!
    @IBOutlet weak var chatBtn: UIButton!
    
    lazy var imgViews: UIImageView = {
        let img = UIImage(named: "Group")
        let imgView = UIImageView(image: img)
        imgView.frame = CGRect(x: 31, y: 348, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        imgView.contentMode = .scaleAspectFit

        return imgView
    }()
    
    let dateFormatter = DateFormatter()
    var entryThisMonth: Date?
    var userChat: [Input]?
    var quoteOfTheDay: String = "Don't forget to smile"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "EntryListViewCell", bundle: nil), forCellReuseIdentifier: EntryListViewCell.identifier)
        
        getCurrentUser()
        viewStyling()
    }
    
    func checkEntry() {
        if ((userChat?.isEmpty) != nil) {
            tableView.isHidden = true
            view.addSubview(imgViews)
        }
        else {
            tableView.isHidden = false
            imgViews.removeFromSuperview()
        }
    }
    
    func getCurrentUser() {
        let db = Firestore.firestore()
        //get uid
        let users = Auth.auth().currentUser
        let path = "users/\(users?.uid ?? "nil")"
//        print(path)
        // read document specific path with uid
        let docRef = db.document(path)
        docRef.getDocument { snapshot, error in
            //get data and check if it's not nil
            guard let userdata = snapshot?.data(), error == nil else {
                return
            }
            //typecast data to a string
            guard let username = userdata["username"] as? String else {
                return
            }
            
            self.greetTxt.text = "Hi, " + username
        }
    }
    
    func viewStyling() {
        let spacer = " "
        viewQuotes.layer.cornerRadius = 10
        fetchData()
        quoteTxt.numberOfLines = 3
        quoteTxt.font = UIFont.italicSystemFont(ofSize: 17)
        authorTxt.font = UIFont.italicSystemFont(ofSize: 17)
        
        dateFormatter.dateFormat = "MMMM, yyyy"
        entryThisMonth = Date()
        
        changeDateBtn.setTitle(dateFormatter.string(from: entryThisMonth!) + spacer + spacer, for: .normal)
        changeDateBtn.setImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        changeDateBtn.contentHorizontalAlignment = .left
        changeDateBtn.semanticContentAttribute = .forceRightToLeft
        
        chatBtn.layer.cornerRadius = chatBtn.frame.width / 2
        
        //fetch user chat
        Task.init {
            let chats = await fetchedChat()
            self.userChat = chats
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        //check if entry is available
        checkEntry()
        
    }
    
    func fetchData() {
            let url = URL(string: "https://type.fit/api/quotes")

            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error")
                    return
                }
                
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                    
                    let nsarr = parsedData! as NSArray
                    let x = Int.random(in: 0...(nsarr.count - 1))
                    let author = (nsarr[x] as AnyObject).value(forKey: "author") as? String
                    let quote = (nsarr[x] as AnyObject).value(forKey: "text") as? String
                    
                    DispatchQueue.main.async {
                        self.quoteTxt.text = "\"" + (quote ?? "Please refresh quotes") + "\""
                        self.authorTxt.text = "- " + (author ?? "Annon")
                        
                        self.quoteOfTheDay = (quote ?? "DEBUG NILL")
                    }
                    
                } catch {
                    print(error)
                }
            }
            task.resume()
       
        }
    
    @IBAction func goToChat(_ sender: Any) {
        self.navigationController?.pushViewController(ChatController(), animated: true)
    }
    
    @IBAction func refreshData(_ sender: Any) {
        fetchData()
    }
    
    
    @IBAction func goToSettings(_ sender: Any) {
        let sb = UIStoryboard(name: "Settings", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SettingView") as! SettingsViewController
        vc.quotes = quoteOfTheDay
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchedChat() async -> [Input] {
        do {
            let arr = try await ChatServiceClass.fetchMessages()
            return arr
        } catch {
            print("Error while fetching user chat")
            return []
        }
    }
    
    @IBAction func pickMonthYear(_ sender: Any) {
        let vc = ModalPickMonthController()
        vc.selectMonthYearDelegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userChat?.count ?? 0
    }
    
    func emojiMoodConverter(emoji: String) -> String {
        var temp: String = ""
        
        if emoji == "😡 Angry" {
            temp = "😡"
        }
        else if emoji == "🤢 Disgusted" {
            temp = "🤢"
        }
        else if emoji == "😊 Happy" {
            temp = "😊"
        }
        else if emoji == "😭 Sad" {
            temp = "😭"
        }
        else if emoji == "😔 Bad" {
            temp = "😔"
        }
        
        return temp
    }
    
    func emojiCausesConverter(emoji: String) -> String {
        var temp: String = ""
        
        if emoji == "💼 Work" {
            temp = "💼"
        }
        else if emoji == "🏫 School" {
            temp = "🏫"
        }
        else if emoji == "👫🏻 Relationships" {
            temp = "👫🏻"
        }
        else if emoji == "😕 Insecurities" {
            temp = "😕"
        }
        else if emoji == "Other" {
            temp = "Other"
        }
        
        return temp
    }
    
    func trimEmojis(emoji: String) -> String {
        var temp: String = ""
        
        if emoji == "😡 Angry" {
            temp = "Angry"
        }
        else if emoji == "🤢 Disgusted" {
            temp = "Disgusted"
        }
        else if emoji == "😊 Happy" {
            temp = "Happy"
        }
        else if emoji == "😭 Sad" {
            temp = "Sad"
        }
        else if emoji == "😔 Bad" {
            temp = "Bad"
        }
        else if emoji == "💼 Work" {
            temp = "Work"
        }
        else if emoji == "🏫 School" {
            temp = "School"
        }
        else if emoji == "👫🏻 Relationships" {
            temp = "Relationships"
        }
        else if emoji == "😕 Insecurities" {
            temp = "Insecurities"
        }
        else if emoji == "Other" {
            temp = "Other"
        }
        
        return temp
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EntryListViewCell.identifier, for: indexPath) as! EntryListViewCell
        
        let temp = userChat?[indexPath.row].answer3
        let emoji = emojiMoodConverter(emoji: temp!)
        cell.emotionTxt.text = emoji
        cell.causesTxt.text = userChat?[indexPath.row].answer1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "viewEntry") as! ViewEntryController
        
        let emojiTemp1 = userChat?[indexPath.row].answer3
        let emojiTemp2 = userChat?[indexPath.row].answer1
        let emoji1 = emojiMoodConverter(emoji: emojiTemp1!)
        let emoji2 = emojiCausesConverter(emoji: emojiTemp2!)
        let answ1 = trimEmojis(emoji: emojiTemp1!)
        let answ2 = trimEmojis(emoji: emojiTemp2!)
        
        vc.answ1 = answ1
        vc.emoji1 = emoji1
        vc.answ2 = answ2
        vc.emoji2 = emoji2
        vc.answ3 = (userChat?[indexPath.row].answer4 ?? "DEBUG: NILL")
        vc.answ4 = (userChat?[indexPath.row].answer2 ?? "DEBUG: NILL")
        vc.answ5 = (userChat?[indexPath.row].answer5 ?? "DEBUG: NILL")
        vc.answ6 = (userChat?[indexPath.row].answer6 ?? "DEBUG: NILL")
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeController: SelectMonthYearDelegate {
    
    func ChangeMonthYearDelegate(date: Date) {
        self.changeDateBtn.setTitle(dateFormatter.string(from: date), for: .normal)
    }
    
}
