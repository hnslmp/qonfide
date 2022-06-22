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
        viewStyling()
        tableView.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    
    func viewStyling() {
        tableView.isHidden = true
        view.addSubview(imageView)
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
