//
//  PupularCityTableViewController.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/15/25.
//

import UIKit

class PupularCityTableViewController: UITableViewController {
    let cities = CityInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNib()
    }

    func configureNib() {
        let xib = UINib(nibName: "PupularCityTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "PupularCityTableViewCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.city.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PupularCityTableViewCell", for: indexPath) as! PupularCityTableViewCell
        cell.configureUI(row: cities.city[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
