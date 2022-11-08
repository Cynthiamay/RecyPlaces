//
//  ViewConfiguration.swift
//  RecyPlaces
//
//  Created by cynthia watanabe on 07/11/22.
//

import Foundation

protocol ViewConfiguration {
    func setupViewConfiguration()
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewConfiguration {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
