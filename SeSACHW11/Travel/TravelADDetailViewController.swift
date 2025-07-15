//
//  TravelADDetailViewController.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/15/25.
//

import UIKit

class TravelADDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        settingNavigation()
    }

    func settingNavigation() {
        navigationItem.title = "광고화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @objc func close() {
        dismiss(animated: true)
    }
}
