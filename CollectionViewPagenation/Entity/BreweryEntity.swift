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
    var ibu: Int
    var targetFg: Int
    var targetOg: Int
    var ebc: Int
    var srm: Int
    var ph: Float
    var attenuationLevel: Int
    var volume: BreweryVolumn
    var boilVolumn: BreweryBoilVolumn
    var method: BreweryMethod
    var ingredients: BreweryIngredients
    var foodPairing: [String]
    var brewersTips: String
    var contributedBy: String
}

struct BreweryVolumn: Decodable {
    var value: Int
    var unit: String
}

struct BreweryBoilVolumn: Decodable {
    var value: Int
    var unit: String
}

struct BreweryMethod: Decodable {
    var mashTemp: [MashTemp]
    var fermentation: MashTemp
    var twist: String?
}

struct MashTemp: Decodable {
    var temp: Temp
    var duration: Int
}

struct Temp: Decodable {
    var value: Int
    var unit: String
}

struct BreweryIngredients: Decodable {
    var malt: [Malt]
    var hops: [Hops]
    var yeast: String
}

struct Malt: Decodable {
    var name: String
    var amount: Amount
}

struct Amount: Decodable {
    var value: Double
    var unit: String
}

struct Hops: Decodable {
    var name: String
    var amount: Amount
    var add: String
    var attribute: String
}

