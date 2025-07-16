//
//  PupularCityViewController.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/16/25.
//
import UIKit

class PopularCityViewController: UIViewController {
    private enum Constants {
		static let popularCityTableViewCell = "PopularCityTableViewCell"
        static let searchPlaceholder = "도시 검색"
        static let popularCityDetailViewController = "PopularCityDetailViewController"
    }

    let cities = CityInfo()
    var filteredCities: [City] = []

    @IBOutlet var tableView: UITableView!
    @IBOutlet var segumentController: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        configureNib()
        segumentController.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        configureSearchController()
        didChangeValue(segment: segumentController)
    }

    func configureNib() {
        let xib = UINib(nibName: Constants.popularCityTableViewCell, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: Constants.popularCityTableViewCell)
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

    func configureSearchController() {
		let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = Constants.searchPlaceholder
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension PopularCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.popularCityTableViewCell, for: indexPath) as! PopularCityTableViewCell
        cell.configureUI(row: filteredCities[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    	let cityName = filteredCities[indexPath.row].city_name
        let vc = self.storyboard?.instantiateViewController(identifier: Constants.popularCityDetailViewController) as! PopularCityDetailViewController
        vc.cityName = cityName

        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PopularCityViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print(#function)
        let keyword = (searchController.searchBar.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

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

        tableView.reloadData()
    }
}
