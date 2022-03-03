//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    
    @IBOutlet weak var tableView: UITableView!
    
    // –––––– TODO: Initialize restaurantsArray
    
    var restaurantsArray: [[String: Any?]] = []
    
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        getAPIData()
        

    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData(){
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            print(restaurants)
            self.restaurantsArray = restaurants
            self.tableView.reloadData()
        }
    }
    
    //Protocol Stubs
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        let restaurant = restaurantsArray[indexPath.row]
        
        //Set Label to restaurant name for each cell
        cell.label.text = restaurant["name"] as? String ?? ""
        
        //Set image of restaurant
        if let imageUrlString = restaurant["image_url"] as? String {
            let imageUrl = URL(string: imageUrlString)
            cell.restaurantImage.af.setImage(withURL: imageUrl!)
        }
        
        //Set the rating of the restaurant
        let rating: Double = restaurant["rating"] as? Double ?? 0
        switch rating {
        case 5:
            cell.ratingImage.image = UIImage(named: "regular_5")
        case 4.5:
            cell.ratingImage.image = UIImage(named: "regular_4_half")
        case 4.0:
            cell.ratingImage.image = UIImage(named: "regular_4")
        case 3.5:
            cell.ratingImage.image = UIImage(named: "regular_3_half")
        case 3.0:
            cell.ratingImage.image = UIImage(named: "regular_3")
        case 2.5:
            cell.ratingImage.image = UIImage(named: "regular_2_half")
        case 2.0:
            cell.ratingImage.image = UIImage(named: "regular_2")
        case 1.5:
            cell.ratingImage.image = UIImage(named: "regular_1_half")
        case 1.0:
            cell.ratingImage.image = UIImage(named: "regular_1")
        default:
            cell.ratingImage.image = UIImage(named: "regular_0")
            
        }
        
        guard let categories = restaurant["categories"] as? [[String:String]] else {
            return cell
        }
        //Set the Cusine label for each cell
        cell.categoryLabel.text = categories[0]["title"] ?? "Other"
        
        

        return cell
    }
    

}

// ––––– TODO: Create tableView Extension and TableView Functionality


