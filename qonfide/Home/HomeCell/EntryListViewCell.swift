//
//  EntryListViewCell.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 23/06/22.
//

import UIKit

class EntryListViewCell: UITableViewCell {
    
    @IBOutlet weak var emotionTxt: UILabel!
    @IBOutlet weak var causesTxt: UILabel!
    @IBOutlet weak var dateTxt: UILabel!
    
    static let identifier = "EntryListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
