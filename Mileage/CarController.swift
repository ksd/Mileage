//
//  CarController.swift
//  Mileage
//
//  Created by ksd on 10/10/2023.
//

import Foundation

class CarController: ObservableObject {
    @Published var cars: [Car] = []
    
    init(){
        if let data = StorageService.read("mileagedata.json"){
            do {
                cars = try JSONDecoder().decode([Car].self, from: data)
            } catch {
                fatalError("JSON Decoding failed \(error.localizedDescription)")
            }
        }
    }
    
    private func store(){
        StorageService.write(cars, toJson: "mileagedata.json")
    }
    
    func add(car: Car) {
        cars.append(car)
        store()
    }
    
}
