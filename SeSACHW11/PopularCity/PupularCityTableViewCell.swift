//
//  PupularCityTableViewCell.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/15/25.
//

import UIKit
import Kingfisher

class PupularCityTableViewCell: UITableViewCell {
    @IBOutlet var cityName: UILabel!
    @IBOutlet var cityExplain: UILabel!
    @IBOutlet var cityImage: UIImageView!
    @IBOutlet var cityCellBackground: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

//        cityImage.layer.cornerRadius = 15
//        cityImage.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
//        cityImage.clipsToBounds = true

//        cityCellBackground.layer.shadowOpacity = 0.5
//        cityCellBackground.layer.shadowOffset = CGSize(width: 0, height: 2)
    
    }

    func configureUI(row: City) {
        cityName.text = "\(row.city_name) | \(row.city_english_name)"
        cityExplain.text = "  \(row.city_explain)"

        if let url = URL(string: row.city_image) {
            let processor = DownsamplingImageProcessor(size: CGSize(width: cityImage.bounds.width, height: cityImage.bounds.height))

            cityImage.kf.setImage(with: url, options: [.processor(processor)])
        }
    }
}
