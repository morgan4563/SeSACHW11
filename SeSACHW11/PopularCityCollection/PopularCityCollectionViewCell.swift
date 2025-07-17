//
//  PopularCityCollectionViewCell.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/17/25.
//

import UIKit
import Kingfisher

class PopularCityCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLable: UILabel!

    var radius: CGFloat = 0

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureUI(item: City) {
        titleLabel.text = "\(item.city_name) | \(item.city_english_name)"
        subTitleLable.text = "  \(item.city_explain)"

        if let url = URL(string: item.city_image) {
            let processor = DownsamplingImageProcessor(size: CGSize(width: imageView.bounds.width * 2, height: imageView.bounds.height * 2))

            imageView.kf.setImage(with: url, options: [.processor(processor)])
            imageView.layer.cornerRadius = radius
            imageView.clipsToBounds = true
        }
    }
}
