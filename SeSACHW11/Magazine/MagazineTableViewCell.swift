//
//  MagazineTableViewCell.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/14/25.
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

    func configure(row: Magazine, df: DateFormatter) {
        titleLabel.text = row.title
        subtitleLabel.text = row.subtitle

        if let url = URL(string: row.photo_image) {
            photoImage.kf.setImage(with: url)
        }
        if let date = df.date(from: row.date) {
            dateLabel.text = df.string(from: date)
        }
    }
}
