//
//  LaunchScreenViewController.swift
//  RecyPlaces
//
//  Created by cynthia watanabe on 08/11/22.
//

import Foundation
import UIKit

class LaunchScreenViewController: UIViewController {
    lazy var gif: UIImageView = {
        let gif = UIImageView()
        return gif
    }()
    
    override func viewDidLoad() {
        setupViewConfiguration()
        gif.loadGif(name: "RecyPlaces-2")
        let seconds = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            let vc = NearMeTableViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension LaunchScreenViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(gif)
    }
    
    func setupConstraints() {
        gif.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func configureViews() {
        view.backgroundColor = .white
    }
    
    
}
