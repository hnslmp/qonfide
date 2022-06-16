//
//  OnboardViewController.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 16/06/22.
//

import UIKit

class OnboardViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    var scrollFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var onboardData: [Onboard] = [Onboard(titles: "Welcome to Qonfide", desc: "Recognize your emotion better and work towards a healthier emotional regulation.", imageView: "Earth and Moon-cuate", imageBackGround: "CShape1"), Onboard(titles: "Meet Bob!", desc: "Confide to Bob, your personal Qonfide assistant. All your stories are safe between you and Bob.", imageView: "World-cuate", imageBackGround: "CShape2"), Onboard(titles: "Start taking care of your emotions", desc: "We’ve carefully crafted guiding questions to create a meaningful journaling experience for you.", imageView: "Cat astronaut-cuate", imageBackGround: "CShape3")]
    
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        for index in 0..<onboardData.count {
            scrollFrame.origin.x = scrollWidth * CGFloat(index)
            scrollFrame.size = CGSize(width: scrollWidth, height: scrollHeight)
            
            let slide = UIView(frame: scrollFrame)
            
//            subviews (ex: title, desc, etc)
            let backgroundImg = UIImageView.init(image: UIImage(named: onboardData[index].imageView))
            backgroundImg.frame = CGRect(x: 0, y: 336, width: 414, height: 560)
            backgroundImg.contentMode = .scaleToFill
//            backgroundImg.center = CGPoint(x: scrollWidth/2, y: scrollHeight/2 - 50)
//
            let imageView = UIImageView.init(image: UIImage(named: onboardData[index].imageView))
            imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            imageView.contentMode = .scaleToFill
            imageView.center = CGPoint(x: scrollWidth/2, y: scrollHeight/2 - 50)
            
            let title = UILabel.init(frame: CGRect(x: 32, y: imageView.frame.maxY + 30, width: scrollWidth-63, height: 30))
            title.textAlignment = .left
            title.font = UIFont.boldSystemFont(ofSize: 20.0)
            title.text = onboardData[index].titles
            
            let desc = UILabel.init(frame: CGRect(x: 32, y: title.frame.maxY+10, width: scrollWidth-64, height: 30))
            desc.textAlignment = .left
            desc.numberOfLines = 3
            desc.font = UIFont.systemFont(ofSize: 18)
            desc.text = onboardData[index].desc
            
            let button = UIButton(frame: CGRect(x: 10, y: desc.frame.maxY + 10, width: 150, height: 50))
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(red: 53/255, green: 74/255, blue: 166/255, alpha: 100)
            button.setTitle("Get Started", for: .normal)
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            
            if index == onboardData.count - 1 {
                slide.addSubview(button)
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func didTapButton(_ button: UIButton) {
        
    }

    @IBAction func pageChanged(_ sender: Any) {
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
