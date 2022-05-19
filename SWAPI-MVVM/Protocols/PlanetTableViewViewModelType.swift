//
//  PlanetProtocol.swift
//  SWAPI-MVVM
//
//  Created by Wheatley on 11.05.2022.
//

import Foundation

protocol PlanetTableViewViewModelType {
    var planetNameList: [String] { get }
    var planetUrlList: [String] {get}
    func planetsCount() -> Int
    var title: String {get}
    func requestPlanetList(url: String, completion: @escaping () -> Void)
}
