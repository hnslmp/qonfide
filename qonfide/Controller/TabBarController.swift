//
//  TabBarController.swift
//  qonfide
//
//  Created by Hansel Matthew on 20/06/22.
//

import UIKit


class TabBarController: UITabBarController{
    
    private let SummaryVC = SummaryController()
    
    //TODO: Change into vc yg beners
    private let ListEntriesVC = ViewController()
    private let ChatInputVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        SummaryVC.title = "Summary"
        ListEntriesVC.title = "Entries"
        ChatInputVC.title = "ChatInput"
        
        self.setViewControllers([ListEntriesVC, ChatInputVC, SummaryVC], animated: true)

//        let chatTintColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.tabBar.layer.shadowRadius = 2
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowOpacity = 0.3
        
        self.tabBar.layer.cornerRadius = 10
        
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 1)
                
        if let tabBarItem1 = self.tabBar.items?[0] {
            tabBarItem1.image = UIImage(systemName: "book")
            tabBarItem1.selectedImage = UIImage(systemName: "book.fill")        }
        if let tabBarItem2 = self.tabBar.items?[1] {
            tabBarItem2.image = UIImage(systemName: "plus.circle.fill")
            tabBarItem2.selectedImage = UIImage(systemName: "plus.circle.fill")
        }
        if let tabBarItem3 = self.tabBar.items?[2] {
            tabBarItem3.image = UIImage(systemName: "chart.bar")
            tabBarItem3.selectedImage = UIImage(systemName: "chart.bar.fill")
        }
                
    }
}
