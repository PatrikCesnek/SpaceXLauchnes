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
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.fetchLaunches()
    }
    
    private func setupUI() {
        title = Constants.Strings.appTitle
        view.backgroundColor = .white
        navigationItem.title = Constants.Strings.appTitle

        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.placeholder = Constants.Strings.searchBarPlaceholder
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        refreshControl.addTarget(self, action: #selector(refreshLaunches), for: .valueChanged)
        tableView.refreshControl = refreshControl

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Constants.Strings.sort,
            style: .plain,
            target: self,
            action: #selector(showSortingOptions)
        )
    }
    
    private func fetchLaunches() {
        viewModel.fetchLaunches { errorMessage in
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
            if let message = errorMessage {
                self.showErrorAlert(message: message)
            }
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: Constants.Strings.errorTitle,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: Constants.Strings.retry, style: .default) { _ in
            self.fetchLaunches()
        })
        
        alert.addAction(UIAlertAction(title: Constants.Strings.cancel, style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc private func refreshLaunches() {
        fetchLaunches()
    }
    
    @objc private func showSortingOptions() {
        let alert = UIAlertController(
            title: Constants.Strings.sortBy,
            message: nil, preferredStyle: .actionSheet
        )
        for option in LaunchesViewModel.SortingOption.allCases {
            alert.addAction(
                UIAlertAction(
                    title: option.localized,
                    style: .default
                ) { _ in
                    self.viewModel.sortingOption = option
                    self.viewModel.applySorting()
                    self.tableView.reloadData()
                })
        }
        
        alert.addAction(
            UIAlertAction(
                title: Constants.Strings.cancel,
                style: .cancel
            )
        )
        
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
        let formattedDate = viewModel.formattedDate(for: launch)
        
        let detailView = LaunchDetailView(launch: launch, formattedDate: formattedDate)
        let hostingController = UIHostingController(rootView: detailView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchLaunches(query: searchText)
        tableView.reloadData()
    }
}
