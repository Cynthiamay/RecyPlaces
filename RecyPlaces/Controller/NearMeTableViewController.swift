//
//  NearMeTableViewController.swift
//  RecyPlaces
//
//  Created by cynthia watanabe on 07/11/22.
//

import Foundation
import UIKit

class NearMeTableViewController: UITableViewController {
    
    var categoryPlaces = ["Reciclagem","Ecoponto","Coleta de entulhos"]
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.register(cellType: NearMeTableViewCell.self)
        populatepuCategoriesForPlaces()
        self.tableView.reloadData()
        self.title = "Escolha a categoria"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(for: indexPath,
                                                 cellType: NearMeTableViewCell.self)
        let place = self.places[indexPath.row]
        cell.setup(title: place.title)
        return cell
    }
    
    private func populatepuCategoriesForPlaces() {
        
        for category in categoryPlaces {
            
            let place = Place()
            place.title = category
            self.places.append(place)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ContainerViewController()
        let place = self.places[indexPath.row]
        vc.place = place
        navigationController?.pushViewController(vc, animated: true)
    }
}
