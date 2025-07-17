//
//  PopularCityCollectionViewController.swift
//  SeSACHW11
//
//  Created by hyunMac on 7/17/25.
//

import UIKit

class PopularCityCollectionViewController: UIViewController {
    private enum Constants {
        static let popularCityCollectionViewCell = "PopularCityCollectionViewCell"
        static let searchPlaceholder = "도시 검색"
    }

    let cities = CityInfo()
    var filteredCities: [City] = []
    var collectionCellRadius: CGFloat = 0
    var lastKeyword = ""

    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let xib = UINib(nibName: Constants.popularCityCollectionViewCell, bundle: nil)

        collectionView.register(xib, forCellWithReuseIdentifier: Constants.popularCityCollectionViewCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        segmentControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)

        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (16 * 2) - (16 * 1)
        collectionCellRadius = cellWidth/4

        layout.itemSize = CGSize(width: cellWidth/2, height: cellWidth/2 + 70)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .vertical

        collectionView.collectionViewLayout = layout
		didChangeValue(segment: segmentControl)
        configureSearchController()
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
        collectionView.reloadData()
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

extension PopularCityCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.popularCityCollectionViewCell, for: indexPath) as! PopularCityCollectionViewCell

        cell.radius = collectionCellRadius
        cell.configureUI(item: filteredCities[indexPath.item])

        return cell
    }
}

extension PopularCityCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = (searchController.searchBar.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        if keyword.isEmpty {
            if !lastKeyword.isEmpty {
                didChangeValue(segment: segmentControl)
            }
            lastKeyword = ""
            return
        }

        let segIndex = segmentControl.selectedSegmentIndex

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
        lastKeyword = keyword
        collectionView.reloadData()
    }
}
