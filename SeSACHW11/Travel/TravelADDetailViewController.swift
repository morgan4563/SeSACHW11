//
//  TravelADDetailViewController.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/15/25.
//

import UIKit

class TravelADDetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!

    var travel: Travel = Travel(title: "", description: nil, travel_image: nil, grade: nil, save: nil, ad: true)

    override func viewDidLoad() {
        super.viewDidLoad()

        settingNavigation()
    }

    func settingNavigation() {
        titleLabel.text = travel.title

        navigationItem.title = "광고화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @objc func close() {
        dismiss(animated: true)
    }
}
