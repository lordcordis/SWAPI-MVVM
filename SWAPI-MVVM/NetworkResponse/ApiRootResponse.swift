//
//  ApiRootResponse.swift
//  SWAPI-MVVM
//
//  Created by Wheatley on 17.05.2022.
//

import Foundation

// MARK: - APIRoot
struct APIRoot: Codable {
    let people, planets, films, species: String
    let vehicles, starships: String
}
