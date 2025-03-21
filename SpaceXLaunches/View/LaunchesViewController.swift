//
//  LaunchesViewController.swift
//  SpaceXLaunches
//
//  Created by Patrik Cesnek on 21/03/2025.
//

import SwiftUI
import UIKit

class LaunchesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private let viewModel = LaunchesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchLaunches { self.tableView.reloadData() }
    }
    
    private func setupUI() {
        title = Constants.Strings.appTitle
        view.backgroundColor = .white
        
        searchBar.delegate = self
        searchBar.placeholder = Constants.Strings.searchBarPlaceholder
        navigationItem.titleView = searchBar
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.Strings.sort, style: .plain, target: self, action: #selector(showSortingOptions))
    }
    
    @objc private func showSortingOptions() {
        let alert = UIAlertController(title: Constants.Strings.sortBy, message: nil, preferredStyle: .actionSheet)
        for option in LaunchesViewModel.SortingOption.allCases {
            alert.addAction(UIAlertAction(title: option.localized, style: .default) { _ in
                self.viewModel.sortingOption = option
                self.viewModel.applySorting()
                self.tableView.reloadData()
            })
        }
        alert.addAction(UIAlertAction(title: Constants.Strings.cancel, style: .cancel))
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredLaunches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath)
        let launch = viewModel.filteredLaunches[indexPath.row]
        cell.textLabel?.text = launch.missionName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let launch = viewModel.filteredLaunches[indexPath.row]
        let detailView = LaunchDetailView(launch: launch)
        let hostingController = UIHostingController(rootView: detailView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchLaunches(query: searchText)
        tableView.reloadData()
    }
}
