//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by Kiseok on 3/24/24.
//

import SnapKit
import UIKit

protocol StationSearchViewControllerDelegate {
    func showStationDetailView(_ staion: StationDetail)
}

class StationSearchViewController: UIViewController {
    private let viewModel: StationSearchViewModel
    private let tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.isHidden = true
        
        return tableView
    }()
    var delegate: StationSearchViewControllerDelegate?
    
    init(viewModel: StationSearchViewModel, delegate: StationSearchViewControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupTableView()
        setupNavigationItems()
        bindViewModel()
    }
    
    private func bindViewModel() {
        self.viewModel.stations.bind { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: ConfigureUI
extension StationSearchViewController {
    private func configureUI() {
        view.addSubview(self.tableView)
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationItems() {
        let searchController: UISearchController = .init()
        searchController.searchBar.placeholder = "지하철역을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        navigationItem.searchController = searchController
    }
}

// MARK: SearchBarDelegate
extension StationSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.tableView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.requestStationInfo(by: searchText)
    }
}

// MARK: TableView DataSource, Delegate
extension StationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.stations.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let station = self.viewModel.stations.value[indexPath.row]
        let cell: UITableViewCell = .init(style: .subtitle, reuseIdentifier: "Cell")
        var content = cell.defaultContentConfiguration()
        content.text = station.stationName
        content.secondaryText = station.lineNumber
        cell.contentConfiguration = content
        
        return cell
    }
}

extension StationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = self.viewModel.stations.value[indexPath.row]
        self.delegate?.showStationDetailView(station)
    }
}
