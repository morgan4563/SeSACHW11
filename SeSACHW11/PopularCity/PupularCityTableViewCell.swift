//
//  PupularCityTableViewCell.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/15/25.
//

import UIKit
import Kingfisher

class PupularCityTableViewCell: UITableViewCell {
    @IBOutlet var cityImageFrameShawdow: UIView!
    @IBOutlet var cityImageFrame: UIView!
    @IBOutlet var cityName: UILabel!
    @IBOutlet var cityExplain: UILabel!
    @IBOutlet var cityImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureFrame()
    }
    
    func configureFrame() {
        cityImageFrameShawdow.layer.cornerRadius = 15
        cityImageFrameShawdow.layer.shadowOpacity = 0.5
        cityImageFrameShawdow.layer.shadowOffset = CGSize(width: 0, height: 4)
        cityImageFrameShawdow.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        cityImageFrameShawdow.clipsToBounds = false

        cityImageFrame.layer.cornerRadius = 15
        cityImageFrame.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        cityImageFrame.clipsToBounds = true
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
