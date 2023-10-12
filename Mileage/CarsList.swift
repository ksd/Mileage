//
//  CarsList.swift
//  Mileage
//
//  Created by ksd on 10/10/2023.
//

import SwiftUI

struct CarsList: View {
    @EnvironmentObject var carController: CarController
    
    init() {
        var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle) /// the default large title font
        titleFont = UIFont(
            descriptor:
                titleFont.fontDescriptor
                .withDesign(.rounded)? /// make rounded
                .withSymbolicTraits(.traitBold) /// make bold
                ??
                titleFont.fontDescriptor, /// return the normal title if customization failed
            size: titleFont.pointSize
        )
        
        /// set the rounded font
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: titleFont]
    }
    
    var body: some View {
        NavigationStack {
            List(carController.cars){car in
                VStack(alignment: .leading) {
                    Text(car.nickName)
                        .font(.largeTitle)
                        .fontDesign(.rounded)
                    Text("\(car.maxMileage)")
                }
            }
            .navigationTitle("Cars")
            .toolbar(content: {
                Button(action: {
                    carController.add(car: Car(nickName: "min Ford", make: .Ford, model: .Focus, maxMileage: 25000, mileages: [.init(mileage: 191000)]))
                }, label: {
                    Text("Add a Car")
                })
            })
        }
    }
}

#Preview {
    CarsList()
        .environmentObject(CarController())
        .environment(\.locale, .init(identifier: "da_DK"))
}
