//
//  TravelTableViewCell.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/13/25.
//

import UIKit

class TravelTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var extraLabel: UILabel!
    @IBOutlet var starStackView: UIStackView!

    @IBOutlet var travelImagebackgroundView: UIView!
    @IBOutlet var travelImage: UIImageView!
    @IBOutlet var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        travelImagebackgroundView.layer.cornerRadius = 10
        travelImagebackgroundView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
