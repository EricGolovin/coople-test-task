//
//  JobListViewController.swift
//  coople-test-task
//
//  Created by Eric Golovin on 14/08/2023.
//  
//

import UIKit
import Combine
import struct CoopleNetworking.JobList

final class JobListViewController: UIViewController {

    private typealias DataSource = UITableViewDiffableDataSource<Section, JobList.Item>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, JobList.Item>

    private enum Section {
        case main
    }

    // MARK: UI Components

    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        return control
    }()

    private lazy var dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
        let cell: JobCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: item)
        return cell
    }

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.separatorStyle = .none
        table.registeCell(JobCell.self)
        table.refreshControl = refreshControl
        return table
    }()

    // MARK: Private properties

    private var cancellable = Set<AnyCancellable>()
    private let viewModel: JobListViewModel

    // MARK: Initialisers

    init(viewModel: JobListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Method overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        bind()
        viewModel.didLoad()
    }

    // MARK: Set up methods

    private func bind() {
        viewModel.$jobItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self else { return }
                refreshControl.endRefreshing()
                var snapshot = Snapshot()
                snapshot.appendSections([.main])
                snapshot.appendItems(data)
                dataSource.apply(snapshot)
            }
            .store(in: &cancellable)
    }

    // MARK: Private methods

    private func setUpUI() {
        navigationItem.title = "Job List"

        view.addSubview(tableView)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.pin(toEdgesOf: view)
    }

    // MARK: Target Actions methods

    @objc private func refreshControlValueChanged() {
        viewModel.refresh()
    }
}

// MARK: UITableViewDelegate conformance

extension JobListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let jobItem = dataSource.itemIdentifier(for: indexPath) else { return }
        viewModel.didSelectJobItem(jobItem)
    }
}
