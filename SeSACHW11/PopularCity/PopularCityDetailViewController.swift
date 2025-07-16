//
//  PupularCityDetailViewController.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/17/25.
//

import UIKit

class PopularCityDetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    var cityName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = cityName
    }
}
