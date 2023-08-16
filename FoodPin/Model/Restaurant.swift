//
//  Restaurant.swift
//  FoodPin
//
//  Created by Simbarashe Mupfururirwa on 2023/08/15.
//

import Foundation

struct Restaurant: Hashable{
    var name: String
    var type: String
    var location: String
    var image: String
    var isFavourite: Bool
    
    init(name: String, type: String, location: String, image: String, isFavourite: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isFavourite = isFavourite
    }
    
    init(){
        self.init(name: "", type: "", location: "", image: "", isFavourite: false)
    }
}
