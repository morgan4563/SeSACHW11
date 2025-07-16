//
//  PupularCityViewController.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/16/25.
//
import UIKit

class PupularCityViewController: UIViewController {
    let cities = CityInfo()
    var filteredCities: [City] = []

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var segumentController: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
    }
}

extension PupularCityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let keyword = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        let segIndex = segumentController.selectedSegmentIndex

        filteredCities = cities.city.filter { city in
            if segIndex == 1 {
                if !city.domestic_travel {
                     return false
                }
            }
            if segIndex == 2 {
                if city.domestic_travel {
                    return false
                }
            }
            return city.city_name.lowercased().contains(keyword) || city.city_english_name.lowercased().contains(keyword) || city.city_explain.lowercased().contains(keyword)
        }

        print("\(keyword)로 검색한 결과 \(filteredCities.count)개 검색됨")
        filteredCities.forEach {
            print("\($0.city_name) / \($0.city_english_name)")
        }

        return true
    }
}
