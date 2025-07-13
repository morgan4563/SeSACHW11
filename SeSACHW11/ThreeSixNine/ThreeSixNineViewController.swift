//
//  ThreeSixNineViewController.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/13/25.
//

import UIKit

class ThreeSixNineViewController: UIViewController {
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var resultLable: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        numberTextField.delegate = self
    }

    func configureUI() {
        resultLable.text = "사용자 경험을 위해 500 이하로 값을 넣어주세요"
        descriptionLabel.text = "최대 숫자를 입력후 Return 키를 눌러주세요"

        resultLable.adjustsFontSizeToFitWidth = true
        resultLable.minimumScaleFactor = 0.3
    }

    func generateResult(max: Int) {
        var totalClap = 0
        let numbers = (1...max).map {
            var newNumber = ""
            for ch in String($0) {
                if ["3","6","9"].contains(ch) {
                    newNumber.append("👏")
                    totalClap += 1
                } else {
                    newNumber.append(ch)
                }
            }
            return newNumber
        }
        resultLable.text = numbers.joined(separator: ", ")

        descriptionLabel.text = "숫자 \(max)까지 총 박수는 \(totalClap)번 입니다"
    }
}

extension ThreeSixNineViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let max = Int(numberTextField.text ?? "") else {
            print("max값 얻기 실패")
            return false
        }
        generateResult(max: max)
        return true
    }
}
