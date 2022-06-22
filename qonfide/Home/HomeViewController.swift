//
//  HomeViewController.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 20/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData { (quotes) in
            for quote in quotes {
                print(quote.author)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func fetchData(completionHandler: @escaping ([DailyQuotes]) -> Void) {
        let url = URL(string: "https://type.fit/api/quotes")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                let postData = try JSONDecoder().decode([DailyQuotes].self, from: data)
                completionHandler(postData)
            } catch {
                print(error)
            }
        }
        task.resume()
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
