//
//  PlanetInfoViewModelType.swift
//  SWAPI-MVVM
//
//  Created by Wheatley on 11.05.2022.
//

import Foundation

protocol PlanetInfoViewModelType {
    var name: String {get}
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
}


protocol TableViewCellViewModel {
    var name: String {get}
}
