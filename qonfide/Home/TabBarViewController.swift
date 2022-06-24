//
//  TabBarViewController.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 24/06/22.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let initiateIndex:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = initiateIndex
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
