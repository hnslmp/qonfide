//
//  EntryListCell.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 23/06/22.
//

import UIKit

class EntryListCell: UITableViewCell {
    
    static let identifier = "EntryListCell"
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var emojiTxt: UILabel!
    @IBOutlet weak var dateTxt: UILabel!
    @IBOutlet weak var causesTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
