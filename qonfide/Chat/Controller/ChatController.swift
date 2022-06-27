//
//  ChatController.swift
//  qonfide
//
//  Created by Hansel Matthew on 16/06/22.
//

import UIKit

private let reuseIdentifier = "MessageCell"

class ChatController: UICollectionViewController
{
    
    // MARK: - Properties
    private let viewModel = ChatViewModel()
    
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
    
    
    // MARK: - Helpers
    func configureUI(){
        configureNavigationBar(withTitle: getDate(), preferLargeTitles: false)
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.4
        self.navigationController?.navigationBar.layer.masksToBounds = false

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
    
    func presentChoiceModal(buttons: [String]) {
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
    }
}

extension ChatController: CustomModalViewControllerDelegate
{
    func userSelect(choice: String)
    {
        print("DEBUG: ChatController delegate: \(choice)")
        viewModel.userChoice = choice
        if choice.contains("Angry") {
            viewModel.emotionString = choice
        }
        viewModel.configureChat()
    }
}

extension ChatController: TextFieldControllerDelegate {
    
    func userInput(_ inputView: TextFieldController,wantsToSend input: String) {
        inputView.clearMessageText()
        viewModel.userChoice = input
        viewModel.configureChat()
    }
}
