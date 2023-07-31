//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simbarashe Mupfururirwa on 2023/07/27.
//

import UIKit

enum Section {
    case all
}

class RestaurantTableViewController: UITableViewController {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisi", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Loaves", "Cafe Lore", "Confessional", "Barrafina", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, String>()
        snapShot.appendSections([.all])
        snapShot.appendItems(restaurantNames, toSection: .all)
        
        dataSource.apply(snapShot, animatingDifferences: false)
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String>{
        let cellIdentifier = "datacell"
        let dataSource = UITableViewDiffableDataSource<Section, String>(tableView: tableView, cellProvider: {tableView, indexPath, restaurantName in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
            cell.nameLabel.text = restaurantName
            cell.locationLabel.text = self.restaurantLocations[indexPath.row]
            cell.typeLabel.text = self.restaurantTypes[indexPath.row]
            cell.thumbnailImageView.image = UIImage(named: self.restaurantImages[indexPath.row])
            return cell
        }
        )
        
        return dataSource
        
    }

}
