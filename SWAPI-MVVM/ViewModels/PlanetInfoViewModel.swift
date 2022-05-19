//
//  PlanetInfoViewModel.swift
//  SWAPI-MVVM
//
//  Created by Wheatley on 11.05.2022.
//

import Foundation

class PlanetInfoViewModel: PlanetInfoViewModelType {
    
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    
    
    func numberOfSections() -> Int {
        return 1
    }
    
    
    init (name: String) {
        self.name = name
    }
    
    var name: String
    
    
}
