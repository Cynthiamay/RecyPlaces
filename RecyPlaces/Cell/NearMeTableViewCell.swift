//
//  NearMeTableViewCell.swift
//  RecyPlaces
//
//  Created by cynthia watanabe on 07/11/22.
//

import UIKit
import Reusable
import SnapKit

class NearMeTableViewCell: UITableViewCell, Reusable {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setup(title: String?) {
        setupViewConfiguration()
        titleLabel.text = title
        titleLabel.accessibilityTraits = .button
    }
}

extension NearMeTableViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
    
    func configureViews() {
        titleLabel.backgroundColor = .white
    }
}
