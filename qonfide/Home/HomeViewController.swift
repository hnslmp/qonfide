//
//  HomeViewController.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 20/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshQuoteBtn: UIButton!
    @IBOutlet weak var quoteTxt: UILabel!
    @IBOutlet weak var greetTxt: UILabel!
    @IBOutlet weak var changeMonthBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var quotesView: UIView!
    @IBOutlet weak var authorTxt: UILabel!
    @IBOutlet weak var addEntryBtn: UIButton!
    
    lazy private var imageView: UIImageView = {
        let img = UIImage(named: "Group")
        let imgView = UIImageView(image: img)
        imgView.frame = CGRect(x: 45, y: 370, width: 324, height: 350)
        imgView.contentMode = .scaleAspectFit
        
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib.init(nibName: "EntryListCell", bundle: nil), forCellReuseIdentifier: EntryListCell.identifier)
        
        viewStyling()
        // Do any additional setup after loading the view.
    }
    
    func viewStyling() {
//        tableView.isHidden = true
//        view.addSubview(imageView)
        quotesView.layer.cornerRadius = 10
        quoteTxt.numberOfLines = 2
        quoteTxt.text = "\"" + "I wumbo, you wumbo, he she we wumbo" + "\""
        authorTxt.text = "Patrick Star"
        authorTxt.font = UIFont.italicSystemFont(ofSize: 17)
        
        changeMonthBtn.setTitle("June 2022 ", for: .normal)
        changeMonthBtn.setImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        changeMonthBtn.contentHorizontalAlignment = .left
        changeMonthBtn.semanticContentAttribute = .forceRightToLeft
        
        addEntryBtn.layer.cornerRadius = 0.5 * addEntryBtn.bounds.size.width
        addEntryBtn.layer.borderWidth = 1
        addEntryBtn.layer.borderColor = UIColor.gray.cgColor
        
    }
    
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EntryListCell.identifier, for: indexPath) as! EntryListCell
        
        cell.cellView.layer.cornerRadius = 10
        cell.cellView.backgroundColor = UIColor(red: 241/255, green: 247/255, blue: 255/255, alpha: 100)
        cell.emojiTxt.text = "😌"
        cell.causesTxt.text = "Works"
        cell.dateTxt.text = "Saturday, 21 June"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50  ))
//        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width - 15, height: 50))
//
//        label.text = "aaaaaa"
//        label.textColor = .white
//        header.addSubview(label)
//
//        return header
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        35.0
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        66.0
    }
    
}
