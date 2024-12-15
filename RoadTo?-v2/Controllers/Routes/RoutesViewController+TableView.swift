//
//  Untitled.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 29.11.2024.
//

import UIKit

extension RoutesViewController: UITableViewDelegate,UITableViewDataSource {
    
    func setupTableView(){
        routesTableView.register(UINib(nibName: "RoutesTableViewCell", bundle: nil), forCellReuseIdentifier: "RoutesCell")
        
        routesTableView.delegate = self
        routesTableView.dataSource = self
        
        routesTableView.backgroundColor = UIColor(named: K.BrandColors.purple)
        routesTableView.addCornerRadius(30)
        
        routesTableView.rowHeight = UITableView.automaticDimension
        routesTableView.estimatedRowHeight = 125
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedPlaces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoutesCell", for: indexPath) as? RoutesTableViewCell else {
            return UITableViewCell()
        }
        
        let place = likedPlaces[indexPath.row]
        cell.configure(with: place, number: indexPath.row + 1)
        return cell
    }

   
    
    
}
