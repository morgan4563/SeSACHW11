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
    @IBOutlet var adViewBackground: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        adBackgroundView.layer.cornerRadius = 10
        adViewBackground.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
