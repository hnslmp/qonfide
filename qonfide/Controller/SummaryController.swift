//
//  SummaryController.swift
//  qonfide
//
//  Created by Hansel Matthew on 18/06/22.
//

import UIKit

class SummaryController: UIViewController{
    
    // MARK: - Properties
    
    var dataSource: Array<Int> = [1,3,4,5,6,7,8]
    
    var graphViews: Array<UIView> = []
    
    var emotions: Array<UIImage> =  [#imageLiteral(resourceName: "happy"), #imageLiteral(resourceName: "sad"), #imageLiteral(resourceName: "anger"), #imageLiteral(resourceName: "suprised"), #imageLiteral(resourceName: "digusted"), #imageLiteral(resourceName: "fearful"), #imageLiteral(resourceName: "bad")]

    private let summaryTitle: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        return label
    }()
    
    private let graphView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 340, height: 280)
        let border = CALayer()
        border.backgroundColor = UIColor.systemGray.cgColor
        let width = 2
        border.frame = CGRect(x: 0, y: Int(view.frame.size.height) - width, width: Int(view.frame.width), height: width)
        view.layer.addSublayer(border)
        return view
    }()
    
    private let durationControl: UISegmentedControl = {
        let durations = ["Week", "Month"]
        let sc = UISegmentedControl(items: durations)

        return sc
    }()
    
    private let totalEntries: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(red: 241/255, green: 247/255, blue: 255/255, alpha: 1)
        
        //TODO: ganti hitung beneran
        let entriesCount = 7
        
        let label = UILabel()
        let textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        let attributedTitle = NSMutableAttributedString(string: String(entriesCount), attributes: [.foregroundColor: textColor, .font: UIFont.boldSystemFont(ofSize: 50)])
        attributedTitle.append(NSAttributedString(string: "Total Entries This Week", attributes: [.foregroundColor: textColor, .font: UIFont.systemFont(ofSize: 20)]))
        
        label.attributedText = attributedTitle
        view.addSubview(label)
        label.centerX(inView: view)
        label.centerY(inView: view)
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        view.addSubview(summaryTitle)
        summaryTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,paddingTop: 12, paddingLeft: 24)
        
        view.addSubview(durationControl)
        durationControl.selectedSegmentIndex = 0
        durationControl.anchor(top: summaryTitle.bottomAnchor, paddingTop: 24)
        durationControl.centerX(inView: view)
        durationControl.setDimensions(height: 40, width: 330)
        
        view.addSubview(graphView)
        graphView.anchor(top: durationControl.bottomAnchor,left: view.leftAnchor, right: view.rightAnchor,paddingTop: 32, paddingLeft: 24, paddingRight: 24)
    
        graphView.setDimensions(height: graphView.frame.height , width: graphView.frame.width)
        drawGraph()

        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemPink
        view.addSubview(scrollView)
        scrollView.anchor(top: graphView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 60, paddingLeft: 24, paddingBottom: 12, paddingRight: 24)

        scrollView.addSubview(totalEntries)
        totalEntries.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, right: scrollView.rightAnchor)
        totalEntries.setDimensions(height: 80, width: 342)
    }
    
    private func drawGraph()
    {
        let barSpacing: CGFloat = 16.0
        var prevBar: UIView?
        
        graphView.subviews.forEach { $0.removeFromSuperview() }
        graphViews.removeAll()
        
        for index in 0...dataSource.count - 1
        {
            let value = dataSource[index]
            
            let leadingBar = prevBar == nil
                
            let bar = UIView()
            graphViews.append(bar)
            graphView.addSubview(bar)
            bar.backgroundColor = UIColor(red: 133/255, green: 165/255, blue: 210/255, alpha: 1)
            
            bar.layer.cornerRadius = 10
            bar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
            let barHeight = getBarHeight(value)
            let leadingAnchor = leadingBar ? graphView.leadingAnchor : prevBar!.trailingAnchor
            
            bar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bar.heightAnchor.constraint(equalToConstant: barHeight),
                bar.bottomAnchor.constraint(equalTo: graphView.bottomAnchor),
                bar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: barSpacing),
            ])
            
            prevBar?.widthAnchor.constraint(equalTo: bar.widthAnchor).isActive = true
            prevBar = bar
            
            let iv = UIImageView()
            iv.image = emotions[index]
            view.addSubview(iv)
            
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.topAnchor.constraint(equalTo: bar.bottomAnchor, constant: 8).isActive = true
            iv.anchor(top: bar.bottomAnchor, paddingTop: 8)
            iv.leadingAnchor.constraint(equalTo: leadingAnchor, constant:barSpacing+4).isActive = true
            iv.setDimensions(height: 24, width: 24)
        }
        prevBar?.trailingAnchor.constraint(equalTo: graphView.trailingAnchor, constant: -barSpacing).isActive = true
    }
    
    private func getBarHeight(_ dataValue: Int) -> CGFloat
    {
        let topInset = 16.0
        return (graphView.frame.height - topInset) * CGFloat(dataValue) / CGFloat(dataSource.count)
    }
    
}
