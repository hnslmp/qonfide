//
//  HomeController.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 23/06/22.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var greetTxt: UILabel!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var quoteTxt: UILabel!
    @IBOutlet weak var authorTxt: UILabel!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var addEntryBtn: UIButton!
    @IBOutlet weak var changeDateBtn: UIButton!
    @IBOutlet weak var viewQuotes: UIView!
    
    lazy var imgViews: UIImageView = {
        let img = UIImage(named: "Group")
        let imgView = UIImageView(image: img)
        imgView.frame = CGRect(x: 31, y: 348, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        imgView.contentMode = .scaleAspectFit

        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "EntryListViewCell", bundle: nil), forCellReuseIdentifier: EntryListViewCell.identifier)
        viewStyling()
    }
    
    func viewStyling() {
        tableView.isHidden = true
        view.addSubview(imgViews)
        let spacer = " "
        
        greetTxt.text = "Hi, Guest"
        
        viewQuotes.layer.cornerRadius = 10
        
        quoteTxt.numberOfLines = 2
        quoteTxt.text = "\"" + "I wumbo, you wumbo, he she we wumbo" + "\""
        quoteTxt.font = UIFont.italicSystemFont(ofSize: 17)
        authorTxt.text = "Patrick Star"
        authorTxt.font = UIFont.italicSystemFont(ofSize: 17)
            
        changeDateBtn.setTitle("June 2022" + spacer + spacer, for: .normal)
        changeDateBtn.setImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        changeDateBtn.contentHorizontalAlignment = .left
        changeDateBtn.semanticContentAttribute = .forceRightToLeft
        
        addEntryBtn.layer.cornerRadius = 15
        addEntryBtn.layer.cornerCurve = .continuous
        addEntryBtn.layer.borderWidth = 1
        addEntryBtn.layer.borderColor = UIColor.gray.cgColor
    }

}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EntryListViewCell.identifier, for: indexPath) as! EntryListViewCell
        
        return cell
    }
}
