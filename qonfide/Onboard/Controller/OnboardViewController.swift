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
    var onboardData: [Onboard] = [Onboard(titles: "Welcome to\nQonfide", desc: "Recognize your emotion better and work towards a healthier emotional regulation.", imageView: "qonfide vector-1", imageBackGround: "background1"), Onboard(titles: "Meet Bob!", desc: "Confide to Bob, your personal Qonfide assistant. All your stories are safe between you and Bob.", imageView: "qonfide vector-2", imageBackGround: "background2"), Onboard(titles: "Start taking care of your emotions", desc: "We’ve carefully crafted guiding questions to create a meaningful journaling experience for you.", imageView: "qonfide vector-3", imageBackGround: "background3")]
    
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.layoutIfNeeded()
        
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        for index in 0..<onboardData.count {
            scrollFrame.origin.x = scrollWidth * CGFloat(index)
            scrollFrame.size = CGSize(width: scrollWidth, height: scrollHeight)
            
            let slide = UIView(frame: scrollFrame)
            
            let backgroundImg = UIImageView.init(image: UIImage(named: onboardData[index].imageBackGround))
            
            backgroundImg.frame = CGRect(x: 0, y: -50, width: scrollWidth, height: scrollHeight)
            backgroundImg.contentMode = .scaleAspectFit
            let imageView = UIImageView.init(image: UIImage(named: onboardData[index].imageView))
            imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            imageView.contentMode = .scaleAspectFill
            imageView.center = CGPoint(x: scrollWidth/2, y: scrollHeight/2 - 250)
            
//            let title = UILabel.init(frame: CGRect(x: 32, y: imageView.frame.maxY + 50, width: scrollWidth - 50, height: 85))
//            let title = UILabel.init(frame: CGRect(x: 32, y: imageView.frame.maxY + 50, width: scrollWidth - 78, height: 85))
//            title.textAlignment = .left
//            title.numberOfLines = 2
//            title.textColor = .white
//            title.font = UIFont.boldSystemFont(ofSize: 34.0)
//            title.text = onboardData[index].titles
            
            let title = UILabel()

            if index == 2 || index == 0{
                title.frame = CGRect(x: 32, y: imageView.frame.maxY + 50, width: scrollWidth - 50, height: 85)
            } else {
                title.frame = CGRect(x: 32, y: imageView.frame.maxY + 70, width: scrollWidth - 50, height: 85)
            }
            title.textAlignment = .left
            title.numberOfLines = 2
            title.textColor = .white
            title.font = UIFont.boldSystemFont(ofSize: 34.0)
            title.text = onboardData[index].titles
            
            
            let desc = UILabel()
            
            if index == 2 {
                desc.frame = CGRect(x: 32, y: title.frame.maxY + 10, width: scrollWidth - 64, height: 100)
            } else if index == 1 {
                desc.frame = CGRect(x: 32, y: title.frame.maxY + 5, width: scrollWidth - 64, height: 76)
            } else {
                desc.frame = CGRect(x: 32, y: title.frame.maxY + 20, width: scrollWidth - 64, height: 76)
            }
            desc.textAlignment = .left
            desc.numberOfLines = 3
            desc.textColor = .white
            desc.font = UIFont.systemFont(ofSize: 18)
            desc.text = onboardData[index].desc
            
            let button = UIButton(frame: CGRect(x: 32, y: desc.frame.maxY + 20, width: scrollWidth-70, height: 50))
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 10
            button.backgroundColor = UIColor(red: 53/255, green: 74/255, blue: 166/255, alpha: 100)
            button.setTitle("Get Started", for: .normal)
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            
            slide.addSubview(backgroundImg)
            slide.addSubview(imageView)
            slide.addSubview(title)
            slide.addSubview(desc)
            
            if index == onboardData.count - 1 {
                slide.addSubview(button)
            }
            
            scrollView.addSubview(slide)
        }
        
//        set width to accomodate all slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(onboardData.count), height: scrollHeight)
        
//        disable verti scroll
        scrollView.contentSize.height = 1.0
        
        pageControl.numberOfPages = onboardData.count
        pageControl.currentPage = 0
        
        // Do any additional setup after loading the view.
    }
    
    @objc func didTapButton(_ button: UIButton) {
        navigationController?.pushViewController(LoginPageController(), animated: true)
    }

    @IBAction func pageChanged(_ sender: Any) {
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndicatorForCurrentPage()
    }
    
    func setIndicatorForCurrentPage() {
        let page = (scrollView?.contentOffset.x)! / scrollWidth
        pageControl?.currentPage = Int(page)
    }
}
