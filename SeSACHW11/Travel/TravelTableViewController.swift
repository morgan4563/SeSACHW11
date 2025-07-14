//
//  TravelTableViewController.swift
//  SeSACHW10
//
//  Created by hyunMac on 7/11/25.
//

import UIKit
import Kingfisher

class TravelTableViewController: UITableViewController {
    var travelInfo = TravelInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

        let travelXib = UINib(nibName: "TravelTableViewCell", bundle: nil)
        let travelAd = UINib(nibName: "TravelADTableViewCell", bundle: nil)

        tableView.register(travelXib, forCellReuseIdentifier: "TravelTableViewCell")
        tableView.register(travelAd, forCellReuseIdentifier: "TravelADTableViewCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.travel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = travelInfo.travel[indexPath.row]
        if travel.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelADTableViewCell", for: indexPath) as! TravelADTableViewCell
            configureAdCell(cell: cell, travel: travel)

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelTableViewCell", for: indexPath) as!
            TravelTableViewCell

            configureTravelCell(cell: cell, travel: travel, indexPath: indexPath)
            return cell
        }
    }

    func configureAdCell(cell: TravelADTableViewCell, travel: Travel) {
        cell.adTextLabel.text = travel.title
        cell.adBackgroundView.backgroundColor = [.adColor1,.adColor2].randomElement()
    }

    func configureTravelCell(cell: TravelTableViewCell, travel: Travel, indexPath: IndexPath) {
        cell.titleLabel.text = travel.title
        cell.descriptionLabel.text = travel.description

        if let grade = travel.grade {
            for (index,view) in cell.starStackView.arrangedSubviews.enumerated() {
                if let imageView = view as? UIImageView {
                    if index < Int(grade) {
                        imageView.tintColor = .yellow
                    } else {
                        imageView.tintColor = .lightGray
                    }
                }
            }
        }

        if let save = travel.save {
            cell.extraLabel.text = "저장 \(save.formatted(.number))"
        }

        if let like = travel.like {
            let heartImage = like ? "heart" : "heart.fill"
            cell.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
        }

        cell.heartButton.tag = indexPath.row
        cell.heartButton.addTarget(self, action: #selector(heartButtonTapped(_:)), for: .touchUpInside)

        if let travelImageString = travel.travel_image {
            if let url = URL(string: travelImageString) {
                let processor = DownsamplingImageProcessor(size: CGSize(width: cell.travelImage.bounds.width, height: cell.travelImage.bounds.height))

                cell.travelImage.kf.setImage(with: url, options: [.processor(processor)])
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let travelAd = travelInfo.travel[indexPath.row].ad
        return travelAd ? 100: 150
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if travelInfo.travel[indexPath.row].ad {
            tableView.window?.makeToast("광고 셀입니다", position: .top)
        }
    }

    @objc func heartButtonTapped(_ sender: UIButton) {
        travelInfo.travel[sender.tag].like?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
}
