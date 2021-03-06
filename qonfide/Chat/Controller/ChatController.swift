//
//  ChatController.swift
//  qonfide
//
//  Created by Hansel Matthew on 16/06/22.
//

import UIKit
import NaturalLanguage

private let reuseIdentifier = "MessageCell"

protocol ChatControllerDelegate: AnyObject{
    func refreshTable()
}

class ChatController: UICollectionViewController
{
    
    // MARK: - Properties
    private let viewModel = ChatViewModel()
    
    weak var delegate: ChatControllerDelegate?
    
    private var paramData: Array<String> = []
    
    private lazy var saveBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Save ", style: .plain, target: self, action: #selector(completeTapped))
        barButton.tintColor = UIColor(red: 53/255, green: 74/255, blue: 166/255, alpha: 1)
        return barButton
    }()
    
            
    // MARK: - Lifecycle
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureUI()
        viewModel.configureChat()
    }
    
    @objc func completeTapped(){
        ChatServiceClass.processData(paramData)
        delegate?.refreshTable()
        navigationController?.popViewController(animated: true)
        print("DEBUG: Complete Tapped pressed")
    }
    
    // MARK: - Helpers
    func configureUI(){
        navigationController?.isNavigationBarHidden = false
        configureNavigationBar(withTitle: getDate(), preferLargeTitles: false)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 53/255, green: 74/255, blue: 166/255, alpha: 1)
        self.navigationController?.navigationBar.layer.shadowColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 0.5).cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.4
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationItem.rightBarButtonItem = saveBarButton
        
        collectionView.backgroundColor = .white
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
    
    func getDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let result = dateFormatter.string(from: date)
        return result
    }
}

extension ChatController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.message = viewModel.messages[indexPath.row]
        return cell
    }
    
}

extension ChatController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let estimatedSizeCell = MessageCell(frame: frame)
        estimatedSizeCell.message = viewModel.messages[indexPath.row]
        estimatedSizeCell.layoutIfNeeded()
        let targetSize = CGSize(width: view.frame.width, height: 10000)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}

extension ChatController: ChatViewModelDelegate{
    
    func scrollChat() {
        collectionView.scrollToItem(at: IndexPath(item: viewModel.messages.count-1, section: 0), at: .bottom, animated: true)
        collectionView.setContentOffset(CGPoint(x: 0, y: collectionView.contentSize.height-100), animated: true)
    }
    
    func sentimentAnalyst(message: String) -> Double {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = message
        
        // ask for the results
        let (sentiment, _) = tagger.tag(at: message.startIndex, unit: .paragraph, scheme: .sentimentScore)

        // read the sentiment back and print it
        let score = Double(sentiment?.rawValue ?? "0") ?? 0
        
        for value in 1...3 {
            print(value)
        }
        
        return score
    }
    
    func setParam(message: [String]) {
           paramData = message
       }
    
    func presentChoiceModal(buttons: [String]) {
        scrollChat()
        let vc = CustomModalViewController(buttonArray: buttons)
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    func presentTextModal() {
        let vc = TextFieldController()
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    func refreshChat() {
        self.collectionView.reloadData()
        
        if viewModel.counter == 22 {
            collectionView.scrollToItem(at: IndexPath(item: viewModel.messages.count-1, section: 0), at: .top, animated: true)
        }
    }
    
}

extension ChatController: CustomModalViewControllerDelegate
{
    func userSelect(choice: String)
    {
        if choice != "Others" {
            scrollChat()
        }

        if choice.contains("Angry") || choice.contains("Happy") || choice.contains("Surprised") || choice.contains("Sad") || choice.contains("Bad") || choice.contains("Fearful") || choice.contains("Disgusted") {
            viewModel.emotionString = choice
        }
        viewModel.userChoice = choice
        viewModel.configureChat()
    }
}

extension ChatController: TextFieldControllerDelegate {
    
    func userInput(_ inputView: TextFieldController,wantsToSend input: String) {
        scrollChat()
        inputView.clearMessageText()
        viewModel.userChoice = input
        viewModel.configureChat()
    }
}
