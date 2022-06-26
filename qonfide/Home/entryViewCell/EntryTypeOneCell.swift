//
//  EntryTypeOneCell.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 24/06/22.
//

import UIKit

class EntryTypeOneCell: UITableViewCell {

    static let identifier = "EntryTypeOneCell"
    
    @IBOutlet weak var questionTxt: UILabel!
    @IBOutlet weak var emojisTxt: UILabel!
    @IBOutlet weak var answerTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
