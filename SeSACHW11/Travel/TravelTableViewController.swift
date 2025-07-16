//
//  TravelTableViewController.swift
//  SeSACHW10
//
//  Created by hyunMac on 7/11/25.
//

import UIKit
import Kingfisher

class TravelTableViewController: UITableViewController {
    private enum Constants {
        static let travelTableViewCell = "TravelTableViewCell"
        static let travelAdTableViewCell = "TravelADTableViewCell"
        static let detailVC = "TravelDetailViewController"
        static let adDetailVC = "TravelDetailViewController"
        static let storyboardName = "Main"
    }

    var travelInfo = TravelInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

        let travelXib = UINib(nibName: Constants.travelTableViewCell, bundle: nil)
        let travelAd = UINib(nibName: Constants.travelAdTableViewCell, bundle: nil)

        tableView.register(travelXib, forCellReuseIdentifier: Constants.travelTableViewCell)
        tableView.register(travelAd, forCellReuseIdentifier: Constants.travelAdTableViewCell)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.travel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = travelInfo.travel[indexPath.row]
        if travel.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.travelAdTableViewCell, for: indexPath) as! TravelADTableViewCell
            configureAdCell(cell: cell, travel: travel)

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.travelTableViewCell, for: indexPath) as!
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
        let sb = UIStoryboard(name: Constants.storyboardName, bundle: nil)
        if travelInfo.travel[indexPath.row].ad {
            let vc = sb.instantiateViewController(withIdentifier: Constants.adDetailVC) as! TravelADDetailViewController
            vc.travel = travelInfo.travel[indexPath.row]

			let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen

            present(nav, animated: true)
        } else {
            let vc = sb.instantiateViewController(withIdentifier: Constants.detailVC) as! TravelDetailViewController
            vc.travel = travelInfo.travel[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func heartButtonTapped(_ sender: UIButton) {
        travelInfo.travel[sender.tag].like?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }


}
