//
//  MagazineTableViewController.swift
//  SeSACHW10
//
//  Created by hyunMac on 7/13/25.
//

import UIKit
import Kingfisher

class MagazineTableViewController: UITableViewController {
    let magazineInfo = MagazineInfo()
    let df: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yy년 MM월 dd일"
        return df
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let xib = UINib(nibName: "MagazineTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "MagazineTableViewCell")

        tableView.rowHeight = UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineInfo.magazine.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell", for: indexPath) as! MagazineTableViewCell
        let magazine = magazineInfo.magazine[indexPath.row]

        cell.titleLabel.text = magazine.title
        cell.subtitleLabel.text = magazine.subtitle

        if let url = URL(string: magazine.photo_image) {
            cell.photoImage.kf.setImage(with: url)
        }
        if let date = df.date(from: magazine.date) {
            cell.dateLabel.text = df.string(from: date)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
