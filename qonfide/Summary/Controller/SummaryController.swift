//
//  SummaryController.swift
//  qonfide
//
//  Created by Hansel Matthew on 18/06/22.
//

import UIKit

class SummaryController: UIViewController{
    
    // MARK: - Properties
    var dataSource: [String: Int] = ["😊 Happy":0,"😭 Sad":0,"😡 Angry":0,"😮 Surprised":0, "🤢 Disgusted":0, "😱 Fearful":0, "😔 Bad":0]
        
    var emotionCounts: [String: Int] = [:]
    
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
        let durations = ["Past 7 Days", "Past 31 Days"]
        let sc = UISegmentedControl(items: durations)

        return sc
    }()
    
    private let totalEntries: UIView = {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(red: 241/255, green: 247/255, blue: 255/255, alpha: 1)
        
        //TODO: Ganti jadi ambil data asli
        let entriesCount = AppHelper.appInputs.count
        
        let labelNumber = UILabel()
        labelNumber.font = .boldSystemFont(ofSize: 50)
        labelNumber.textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        labelNumber.text = String(entriesCount)
        
        let labelString = UILabel()
        labelString.font = .systemFont(ofSize: 20)
        labelString.textColor = UIColor(red: 51/255, green: 88/255, blue: 141/255, alpha: 1)
        labelString.text = " Total Entries This Week"
        
        let labelStack = UIStackView(arrangedSubviews: [labelNumber, labelString])
        labelStack.axis = .horizontal
        
        view.addSubview(labelStack)
        labelStack.centerX(inView: view)
        labelStack.centerY(inView: view)
        
        return view
    }()
    
    private let averageMood = AverageMoodView()
    
    private let upDownMood = UpDownMoodView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureData()
        drawGraph()
    }
    
    // MARK: - Helpers
    func configureData(){
        let emotions: [String] = AppHelper.appInputs.map{$0.answer3}
        print("DEBUG: Print fetchedinput \(emotions)")
        for item in emotions {
            emotionCounts[item] = (emotionCounts[item] ?? 0) + 1
        }
        dataSource.merge(dict: emotionCounts)
    }
    
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
        
        graphView.translatesAutoresizingMaskIntoConstraints = false
        graphView.heightAnchor.constraint(equalToConstant: graphView.frame.height).isActive = true
        

        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: 330, height: 400)
        
        view.addSubview(scrollView)
        scrollView.anchor(top: graphView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 60, paddingLeft: 24, paddingBottom: 12, paddingRight: 24)

        scrollView.addSubview(totalEntries)
        totalEntries.anchor(top: scrollView.topAnchor, left: scrollView.frameLayoutGuide.leftAnchor, right: scrollView.frameLayoutGuide.rightAnchor)
        
        scrollView.addSubview(averageMood)
        averageMood.anchor(top: totalEntries.bottomAnchor, left: scrollView.frameLayoutGuide.leftAnchor, right: scrollView.frameLayoutGuide.rightAnchor, paddingTop: 12)
        
        scrollView.addSubview(upDownMood)
        upDownMood.anchor(top: averageMood.bottomAnchor, left: scrollView.frameLayoutGuide.leftAnchor, right: scrollView.frameLayoutGuide.rightAnchor, paddingTop: 12)
        
    }
    
    private func drawGraph()
    {
        let barSpacing: CGFloat = 16.0
        var prevBar: UIView?

        graphView.subviews.forEach { $0.removeFromSuperview() }
        graphViews.removeAll()
        
        let dataArray = Array(dataSource.values)
        print("DEBUG: dataSource \(dataSource)")
        print("DEBUG: dataArray \(dataArray)")

        for index in 0...dataArray.count - 1
        {
            let value = dataArray[index]

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
