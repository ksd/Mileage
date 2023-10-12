//
//  Car.swift
//  Mileage
//
//  Created by ksd on 10/10/2023.
//

import Foundation


struct Car: Codable, Identifiable {
    let id = UUID().uuidString
    let nickName: String
    let make: CarMake
    let model: CarModel
    let maxMileage: Int
    let mileages: [Mileage]
    
    enum CarMake: String, Codable {
        case Volvo, Polestar, Ford, Opel
    }
    
    enum CarModel: String, Codable {
        case V60 = "V60"
        case PS2 = "2"
        case Focus = "Focus"
        case Corsa = "Corsa"
    }
    
    struct Mileage: Hashable, Codable {
        let mileage: Int
    }
}

