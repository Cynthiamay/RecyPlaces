//
//  MapViewDetailsTableViewController.swift
//  RecyPlaces
//
//  Created by cynthia watanabe on 07/11/22.
//

import UIKit
import MapKit
import Contacts

class MapViewDetailsTableViewController: UITableViewController {
    
    lazy var placeName: UILabel = {
        let placeName = UILabel()
        placeName.numberOfLines = 0
        placeName.font = UIFont(name: "Helvetica Neue", size: 20)
        placeName.accessibilityTraits = .header
        return placeName
    }()
    
    lazy var placeAddress: UILabel = {
        let placeAddress = UILabel()
        placeAddress.numberOfLines = 0
        return placeAddress
    }()
    
    lazy var placePhone: UILabel = {
        let placePhone = UILabel()
        return placePhone
    }()
    
    var mapItem: MKMapItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     }
    
    func config() {
        setupViewConfiguration()
        let addressElements = self.mapItem.placemark.addressDictionary?["FormattedAddressLines"] as! [String]
        
        self.placeName.text = self.mapItem.name
        self.placeAddress.text = "Endereço: \(addressElements.joined(separator: " "))"
        self.placePhone.text = "Telefone: \(self.mapItem.phoneNumber!)"
    }
}

extension MapViewDetailsTableViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(placeAddress)
        view.addSubview(placePhone)
        view.addSubview(placeName)
    }

    func setupConstraints() {
        placeName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.width.equalTo(UIScreen.main.bounds.width - 48)
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalToSuperview().offset(24)
        }
        
        placeAddress.snp.makeConstraints { make in
            make.top.equalTo(placeName.snp.bottom).offset(24)
            make.width.equalTo(UIScreen.main.bounds.width - 48)
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalToSuperview().offset(24)
        }
        
        placePhone.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 48)
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(placeAddress.snp.bottom).offset(24)
        }
    }

    func configureViews() {
        view.backgroundColor = .white
    }
}
