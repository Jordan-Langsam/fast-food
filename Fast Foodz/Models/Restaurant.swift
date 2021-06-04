//
//  Restaurant.swift
//  Fast Foodz
//
//  Created by Jordan on 5/28/21.
//

import Foundation

private struct Constants {
    static let pizza = "pizza"
    static let mexican = "mexican"
    static let chinese = "chinese"
    static let burgers = "burgers"
    static let tacos = "tacos"
    static let dimsum = "dimsum"
    static let szechuan = "szechuan"
    static let imageNotFound = "imageNotFound"
}

enum FoodType: String {
    case pizza, mexican, chinese, burgers, tacos, dimsum, szechuan, notAvailable
    
    func imageString() -> String {
        switch self {
        case .pizza:
            return FoodType.pizza.rawValue
        case .mexican, .tacos:
            return FoodType.mexican.rawValue
        case .burgers:
            return FoodType.burgers.rawValue
        case .dimsum, .szechuan, .chinese:
            return FoodType.chinese.rawValue
        case .notAvailable:
            return Constants.imageNotFound
        }
    }
        
    static func foodType(for string: String) -> FoodType {
        switch string {
        case FoodType.pizza.rawValue:
            return .pizza
        case FoodType.mexican.rawValue:
            return .mexican
        case FoodType.chinese.rawValue:
            return .chinese
        case FoodType.burgers.rawValue:
            return .burgers
        case FoodType.tacos.rawValue:
            return .tacos
        case FoodType.dimsum.rawValue:
            return .dimsum
        case FoodType.szechuan.rawValue:
            return .szechuan
        default:
            return .notAvailable
        }
    }
}

struct Restaurant: Decodable {
    var name: String
    var coordinates: Coordinates
    var categories: [Categories]
    var phone: String
    var price: String?
    var image_url: String
    var url: String
    var distance: Double

    var display_phone: String
    var foodType: FoodType {

       let foodCategory = categories.first(where: {$0.alias == Constants.pizza || $0.alias == Constants.chinese || $0.alias == Constants.mexican || $0.alias == Constants.burgers
        || $0.alias == Constants.tacos || $0.alias == Constants.dimsum || $0.alias == Constants.szechuan
       })
                
        guard let foodtype = foodCategory?.alias else {
            return .notAvailable
        }
        
        return FoodType.foodType(for: foodtype)
    }
    
    struct Coordinates: Decodable {
        var latitude: Double
        var longitude: Double
    }
    
    struct Categories: Decodable {
        var alias: String
    }
}

struct RestaurantsResponseObject: Decodable {
    var businesses: [Restaurant]
}
