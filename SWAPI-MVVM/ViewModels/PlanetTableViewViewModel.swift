//
//  ViewModel.swift
//  SWAPI-MVVM
//
//  Created by Wheatley on 11.05.2022.
//

import Foundation

class PlanetTableViewViewModel: PlanetTableViewViewModelType {
    
    var planetUrlList: [String] = []
    
    private var planetsUrl = "https://swapi.dev/api/planets/"

    func requestPlanetList(url: String, completion: @escaping () -> Void) {
        requestPlanetsListNetworkResponse(stringURL: planetsUrl) { response in
            print(response.next)
            self.planetsUrl = response.next
            
            let responseURL = response.results.map {$0.url}
            self.planetUrlList.append(contentsOf: responseURL)
            
            let response = response.results.map {$0.name}
            
            self.planetNameList.append(contentsOf: response)
            completion()
        }
    }
    
    var title: String
    
    private var planetsArray: [String] = []
    
    init() {
        planetNameList = planetsArray
        title = "Planets"
    }
    
    
    var planetNameList: [String]
    
    func planetsCount() -> Int {
        return planetsArray.count
    }
    
}



