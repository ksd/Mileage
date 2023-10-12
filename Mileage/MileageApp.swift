//
//  MileageApp.swift
//  Mileage
//
//  Created by ksd on 10/10/2023.
//

import SwiftUI

@main
struct MileageApp: App {
    var body: some Scene {
        WindowGroup {
            CarsList().environmentObject(CarController())
        }
    }
}
