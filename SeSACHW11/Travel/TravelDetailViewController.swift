//
//  TravelDetailViewController.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/15/25.
//

import UIKit
import Kingfisher

class TravelDetailViewController: UIViewController {

    @IBOutlet var travelImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var imageBackgroundView: UIView!
    @IBOutlet var backButton: UIButton!

    var travel: Travel = Travel(title: "", description: nil, travel_image: nil, grade: nil, save: nil, ad: true)

    override func viewDidLoad() {
        super.viewDidLoad()

        UIsetting()
        navigationSetting()
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        close()
    }

    func UIsetting() {
        if let urlString = travel.travel_image {
            if let url = URL(string: urlString) {
                let processor = DownsamplingImageProcessor(size: CGSize(width: travelImage.bounds.width, height: travelImage.bounds.height))
                travelImage.kf.setImage(with: url, options: [.processor(processor)])
            }
        }
        travelImage.contentMode = .scaleAspectFill

        titleLabel.text = travel.title
        descriptionLabel.text = travel.description

        imageBackgroundView.layer.cornerRadius = 15
        imageBackgroundView.clipsToBounds = true

        backButton.layer.cornerRadius = 20
    }

    func navigationSetting() {
        navigationItem.title = "관광지 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(close))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @objc func close() {
        navigationController?.popViewController(animated: true)
    }
}
