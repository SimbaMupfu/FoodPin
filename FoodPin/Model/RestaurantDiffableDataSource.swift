//
//  RestaurantDiffableDataSource.swift
//  FoodPin
//
//  Created by Simbarashe Mupfururirwa on 2023/08/16.
//

import UIKit

enum Section{
    case all
}

class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}
