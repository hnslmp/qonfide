//
//  ReminderCell.swift
//  qonfide
//
//  Created by daniel stefanus christiawan on 18/06/22.
//

import UIKit

class ReminderCell: UITableViewCell {

    static let identifier = "ReminderCell"
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var labelTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
