//
//  TravelADTableViewCell.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/13/25.
//

import UIKit

class TravelADTableViewCell: UITableViewCell {

    @IBOutlet var adTextLabel: UILabel!
    @IBOutlet var adBackgroundView: UIView!
    @IBOutlet var adLabelBackground: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        adBackgroundView.layer.cornerRadius = 10
        adLabelBackground.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
