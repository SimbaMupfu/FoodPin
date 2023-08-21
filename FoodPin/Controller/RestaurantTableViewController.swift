//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simbarashe Mupfururirwa on 2023/07/27.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurants:[Restaurant] = [Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isFavourite: false),
                                    Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image:"homei", isFavourite: false), Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavourite: false), Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavourite: false), Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isFavourite: false), Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkee", isFavourite: false), Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavourite: false), Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavourite: false), Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavourite: false), Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavourite: false), Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavourite: false), Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavourite: false), Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavourite: false), Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "waffleandwolf", isFavourite: false), Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavourite: false), Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavourite: false), Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavourite: false), Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavourite: false), Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavourite: false), Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavourite: false), Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavourite: false)]
    
    var restaurantIsFavourite = Array(repeating: false, count: 21)
    
    lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapShot.appendSections([.all])
        snapShot.appendItems(restaurants, toSection: .all)
        
        dataSource.apply(snapShot, animatingDifferences: false)
        tableView.separatorStyle = .none
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        if let popoverController = optionMenu.popoverPresentationController{
            if let cell = tableView.cellForRow(at: indexPath){
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let reserveActionHandler = { (action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry this feature is not available yet. Please retry later", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
//        let favouriteAction = UIAlertAction(title: "Mark as favourite", style: .default, handler: {
//            (action: UIAlertAction) -> Void in
//            let cell = tableView.cellForRow(at: indexPath)
//            cell?.accessoryType = .checkmark
//
//            self.restaurantIsFavourite[indexPath.row] = true
//        })
        
        let favouriteActionTitle = self.restaurants[indexPath.row].isFavourite ? "Remove from favourites" : "Mark as favourite"
        let favouriteAction = UIAlertAction(title: favouriteActionTitle, style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            cell.accessoryType = .checkmark
            self.restaurants[indexPath.row].isFavourite = self.restaurants[indexPath.row].isFavourite ? false : true
        })
        
        optionMenu.addAction(favouriteAction)
        optionMenu.addAction(reserveAction)
        optionMenu.addAction(cancelAction)
        present(optionMenu, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath)
        else{
            return UISwipeActionsConfiguration()
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {(action, sourceView, completionHandler) in
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            completionHandler(true)
        })
        
        let shareAction = UIContextualAction(style: .normal, title: "Share", handler: {(action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + restaurant.name
            let activityController: UIActivityViewController
            if let imageToShare = UIImage(named: restaurant.image){
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            }else{
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            if let popoverController = activityController.popoverPresentationController{
                if let cell = tableView.cellForRow(at: indexPath){
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        })
        
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant>{
        let cellIdentifier = "favouritecell"
        let dataSource = RestaurantDiffableDataSource(tableView: tableView, cellProvider: {tableView, indexPath, restaurant in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
            cell.nameLabel.text = restaurant.name
            cell.locationLabel.text = restaurant.location
            cell.typeLabel.text = restaurant.type
            cell.thumbnailImageView.image = UIImage(named: restaurant.image)
            cell.accessoryType = restaurant.isFavourite ? .checkmark : .none
            return cell
        }
        )
        
        return dataSource
        
    }

}
