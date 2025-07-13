//
//  MagazineTableViewCell.swift
//  SeSACHW10
//
//  Created by hyunMac on 7/13/25.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {
    @IBOutlet var photoImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageViewContainer: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewContainer.layer.cornerRadius = 10
        imageViewContainer.clipsToBounds = true
    }
}
