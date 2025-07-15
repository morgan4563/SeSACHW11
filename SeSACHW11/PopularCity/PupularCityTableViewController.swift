//
//  PupularCityTableViewController.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/15/25.
//

import UIKit

class PupularCityTableViewController: UITableViewController {
    let cities = CityInfo()
    var filteredCities: [City] = []
    @IBOutlet var segmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNib()
        filteredCities = cities.city
        segmentControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)

    }

    func configureNib() {
        let xib = UINib(nibName: "PupularCityTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "PupularCityTableViewCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PupularCityTableViewCell", for: indexPath) as! PupularCityTableViewCell
        cell.configureUI(row: filteredCities[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    @objc func didChangeValue(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 1:
            filteredCities = cities.city.filter { $0.domestic_travel == true }
        case 2:
            filteredCities = cities.city.filter { $0.domestic_travel == false }
        default:
            filteredCities = cities.city
        }
        tableView.reloadData()
    }

}
