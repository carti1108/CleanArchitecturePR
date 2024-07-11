//
//  StationDetailViewController.swift
//  SubwayStation
//
//  Created by Kiseok on 3/25/24.
//

import RxSwift
import RxCocoa
import UIKit
import SnapKit

final class StationDetailViewController: UIViewController, ReuseIdentifying {
    private let viewModel: StationDetailViewModel
    private let refreshControl: UIRefreshControl = .init()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = .init(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            StationDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: StationDetailCollectionViewCell.reuseIdentifier
        )
        
        return collectionView
    }()
    
    private var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
        setupCollectionView()
        configureUI()
        setupLayout()
        bindViewModel()
        configureTimer()
        refreshData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.disposeBag = .init()
    }
    
    init(viewModel: StationDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindViewModel() {
        self.viewModel.realTimeArrivalList
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                guard let self else { return }
                
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }.disposed(by: disposeBag)
    }
}

// MARK: UI 및 프로퍼티 구성
extension StationDetailViewController {
    private func configureUI() {
        navigationItem.title = self.viewModel.station.stationName
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(
            width: view.frame.width - 32.0,
            height: 100.0
        )
        layout.sectionInset = UIEdgeInsets(
            top: 16.0,
            left: 16.0,
            bottom: 16.0,
            right: 16.0
        )
        layout.scrollDirection = .vertical
        
        self.collectionView.collectionViewLayout = layout
        self.collectionView.refreshControl = self.refreshControl
        self.collectionView.dataSource = self
    }
    
    private func setupRefreshControl() {
        self.refreshControl.addTarget(
            self,
            action: #selector(self.refreshData),
            for: .valueChanged
        )
    }
    
    private func configureTimer() {
        Observable<Int>.interval(.seconds(10), scheduler: MainScheduler.instance)
            .subscribe { [weak self] _ in
                guard let self else { return }
                
                self.refreshData()
            }.disposed(by: disposeBag)
    }
    
    @objc private func refreshData() {
        self.viewModel.requestStationArrival()
            .subscribe(onFailure: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
}

// MARK: CollectionView DataSource
extension StationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        do {
            return try self.viewModel.realTimeArrivalList.value().count
        } catch {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StationDetailCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? StationDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let realTimeArrival = try? self.viewModel.realTimeArrivalList.value()[indexPath.row] else {
            return .init()
        }
        cell.setup(with: realTimeArrival)
        
        return cell
    }
}
