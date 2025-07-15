//
//  TravelDetailViewController.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/15/25.
//

import UIKit

class TravelDetailViewController: UIViewController {

    @IBOutlet var imageBackgroundView: UIView!
    @IBOutlet var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        UIsetting()
        navigationSetting()
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        close()
    }

    func UIsetting() {
        imageBackgroundView.layer.cornerRadius = 15
        imageBackgroundView.clipsToBounds = true

        backButton.layer.cornerRadius = 20
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
