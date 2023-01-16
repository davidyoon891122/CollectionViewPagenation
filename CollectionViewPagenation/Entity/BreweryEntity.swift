//
//  BreweryEntity.swift
//  CollectionViewPagenation
//
//  Created by jiwon Yoon on 2023/01/16.
//

import Foundation

struct BreweryEntity: Decodable {
    var id: Int
    var name: String
    var tagLine: String
    var firstBrewed: String
    var description: String
    var imageURL: String
    var abv: Float
    var ibu: Float?
    var targetFg: Int
    var targetOg: Float
    var ebc: Int?
    var srm: Float?
    var ph: Float?
    var attenuationLevel: Float
    var volume: BreweryVolumn
    var boilVolumn: BreweryBoilVolumn
    var method: BreweryMethod
    var ingredients: BreweryIngredients
    var foodPairing: [String]
    var brewersTips: String
    var contributedBy: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, abv, ibu, ebc, srm, ph, volume, method, ingredients
        case tagLine = "tagline"
        case firstBrewed = "first_brewed"
        case imageURL = "image_url"
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case attenuationLevel = "attenuation_level"
        case boilVolumn = "boil_volume"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}

struct BreweryVolumn: Decodable {
    var value: Int
    var unit: String
    
    enum CodingKeys: String, CodingKey {
        case value, unit
    }
}

struct BreweryBoilVolumn: Decodable {
    var value: Int
    var unit: String
    
    enum CodingKeys: String, CodingKey {
        case value, unit
    }
}

struct BreweryMethod: Decodable {
    var mashTemp: [MashTemp]
    var fermentation: Fermentation
    var twist: String?
    
    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

struct MashTemp: Decodable {
    var temp: Temp
    var duration: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp, duration
    }
}

struct Fermentation: Decodable {
    var temp: Temp
}

struct Temp: Decodable {
    var value: Int
    var unit: String
    
    enum CodingKeys: String, CodingKey {
        case value, unit
    }
}

struct BreweryIngredients: Decodable {
    var malt: [Malt]
    var hops: [Hops]
    var yeast: String
    
    enum CodingKeys: String, CodingKey {
        case malt, hops, yeast
    }
}

struct Malt: Decodable {
    var name: String
    var amount: Amount
    
    enum CodingKeys: String, CodingKey {
        case name, amount
    }
}

struct Amount: Decodable {
    var value: Double
    var unit: String
    
    enum CodingKeys: String, CodingKey {
        case value, unit
    }
}

struct Hops: Decodable {
    var name: String
    var amount: Amount
    var add: String
    var attribute: String
    
    enum CodingKeys: String, CodingKey {
        case name, amount, add, attribute
    }
}

