//
//  StationDetailCollectionViewCell.swift
//  SubwayStation
//
//  Created by Kiseok on 3/25/24.
//

import UIKit
import SnapKit

final class StationDetailCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    private let lineLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        return label
    }()
    private let remainTimeLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with realTimeArrival: RealTimeArrival) {
        self.lineLabel.text = realTimeArrival.line
        self.remainTimeLabel.text = realTimeArrival.remainTime
    }
}

// MARK: UI 구성
extension StationDetailCollectionViewCell {
    private func configureUI() {
        self.layer.cornerRadius = 12.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 10
        
        self.backgroundColor = .systemBackground
        
        [self.lineLabel, self.remainTimeLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func setupLayout() {
        self.lineLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(16.0)
        }
        
        self.remainTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(lineLabel)
            $0.top.equalTo(lineLabel.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
}
