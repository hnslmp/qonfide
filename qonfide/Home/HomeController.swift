//
//  HomeController.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 23/06/22.
//

import UIKit
import Firebase

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
    let data = AppHelper.appInputs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "EntryListViewCell", bundle: nil), forCellReuseIdentifier: EntryListViewCell.identifier)
        
        getCurrentUser()
        viewStyling()
    }
    
    func getCurrentUser() {
        guard let current = Auth.auth().currentUser else {
            print("no user")
            return
        }
        greetTxt.text = "Hi, " + (current.displayName ?? "Haris")
        
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
        self.navigationController?.pushViewController(vc, animated: true)
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
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EntryListViewCell.identifier, for: indexPath) as! EntryListViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "viewEntry")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeController: SelectMonthYearDelegate {
    
    func ChangeMonthYearDelegate(date: Date) {
        self.changeDateBtn.setTitle(dateFormatter.string(from: date), for: .normal)
    }
    
}
