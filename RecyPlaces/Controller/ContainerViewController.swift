//
//  ContainerViewController.swift
//  RecyPlaces
//
//  Created by cynthia watanabe on 07/11/22.
//

import UIKit
import MapKit

class ContainerViewController: UIViewController, MapsViewControllerDelegate {
    
    lazy var topConstraint: NSLayoutConstraint = {
        let constraint = NSLayoutConstraint()
        return constraint
    }()
    
    lazy var topView: UIView = {
        let upView = UIView()
        return upView
    }()
    
    var place: Place!
    var mapsViewController = MapsViewController()
    var mapsDetailsViewController = MapViewDetailsTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfiguration()
        topView.addSubview(mapsViewController.view)
        mapsViewController.delegate = self
        self.mapsViewController.place = self.place
        self.title = place.title
    }
    
    func mapsViewControllerDidSelectAnnotation(mapItem: MKMapItem) {
        self.mapsDetailsViewController.mapItem = mapItem
        self.mapsDetailsViewController.config()
        navigationController?.pushViewController(mapsDetailsViewController, animated: true)
    }
}

extension ContainerViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(topView)
    }
    
    func setupConstraints() {
        topView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    func configureViews() {
    }
}
