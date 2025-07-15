//
//  TravelDetailViewController.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/15/25.
//

import UIKit

class TravelDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationSetting()
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
