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
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.travel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = travelInfo.travel[indexPath.row]
        if travel.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: "adCell", for: indexPath) as! TravelADTableViewCell
            configureAdCell(cell: cell, travel: travel)

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath) as!
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
                cell.travelImage.kf.setImage(with: url)
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let travelAd = travelInfo.travel[indexPath.row].ad
        return travelAd ? 100: 150
    }

    @objc func heartButtonTapped(_ sender: UIButton) {
        travelInfo.travel[sender.tag].like?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
}
