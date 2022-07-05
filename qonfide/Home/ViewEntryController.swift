//
//  viewEntryController.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 24/06/22.
//

import UIKit

class ViewEntryController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewConversationBtn: UIButton!

    let appearence = UINavigationBarAppearance()
    //MARK: -- Dummy
    let date = Date()
    let dateformatter = DateFormatter()
    var dateNow: String?
    let q1 = "What I felt"
    let q2 = "What affected my emotion"
    let q3 = "Intensity of my emotion"
    let q4 = "This is what happen..."
    let q5 = "This is what I did..."
    let q6 = "Activity Suggestion:"
    var emoji1 = "😡"
    var answ1 = "Angry"
    var emoji2 = "🏫"
    var answ2 = "School"
    var answ3 = "A little"
    var answ4 = "School makes me angry because of the amount of work I need to finish."
    var answ5 = "I try to list down the work I need to finish."
    var answ6 = "1. Slowly repeat a calm word or phrase such as relax, take it easy. Repeat it to yourself while breathing deeply. \n2. Use imagery; visualize a relaxing experience, from either your memory or your imagination. \n3. Non-strenuous, slow yoga-like exercises can relax your muscles and make you feel much calmer."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStyling()

        // Do any additional setup after loading the view.
    }
    
    func viewStyling() {
        navigationController?.isNavigationBarHidden = false
        configureNavigationBar(withTitle: getDate(), preferLargeTitles: false)
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.4
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib.init(nibName: "EntryTypeOneCell", bundle: nil), forCellReuseIdentifier: EntryTypeOneCell.identifier)
        self.tableView.register(UINib.init(nibName: "EntryTypeTwoCell", bundle: nil), forCellReuseIdentifier: EntryTypeTwoCell.identifier)
        self.tableView.register(UINib.init(nibName: "EntryTypeThreeCell", bundle: nil), forCellReuseIdentifier: EntryTypeThreeCell.identifier)
        
        appearence.titleTextAttributes = [.foregroundColor: UIColor.blue]
        navigationItem.standardAppearance = appearence
        
        dateformatter.dateFormat = "MM/dd/yyyy"
        dateNow = dateformatter.string(from: date)
        self.title = dateNow
        
        self.viewConversationBtn.layer.cornerRadius = 10
    }
    
    @IBAction func seeConversationTap(_ sender: Any) {
        
    }
    
    func getDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let result = dateFormatter.string(from: date)
        return result
    }
    
}

extension ViewEntryController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EntryTypeOneCell.identifier, for: indexPath) as! EntryTypeOneCell
            
            if indexPath.row == 0 {
                cell.questionTxt.text = q1
                cell.emojisTxt.text = emoji1
                cell.answerTxt.text = answ1
            } else {
                cell.questionTxt.text = q2
                cell.emojisTxt.text = emoji2
                cell.answerTxt.text = answ2
            }
            
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EntryTypeTwoCell.identifier, for: indexPath) as! EntryTypeTwoCell
            
            cell.questionTxt.text = q3
            cell.answerTxt.text = answ3
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: EntryTypeThreeCell.identifier, for: indexPath) as! EntryTypeThreeCell
            
            if indexPath.row == 3 {
                cell.questionTxt.text = q4
                cell.answerTxt.text = answ4
            }
            else if indexPath.row == 4 {
                cell.questionTxt.text = q5
                cell.answerTxt.text = answ5
            }
            else {
                cell.questionTxt.text = q6
                cell.answerTxt.text = answ6
            }
            
            
            return cell
        }
    }

}
