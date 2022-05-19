//
//  ViewController.swift
//  SWAPI-MVVM
//
//  Created by Wheatley on 10.05.2022.
//

import UIKit

class PlanetsMainTableViewController: UITableViewController {
    
    var viewModel: PlanetTableViewViewModel?
    var link: String?
    var type: resultType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PlanetTableViewViewModel()
        title = viewModel?.title
        viewModel?.requestPlanetList(url: link!, completion: {
            self.updateUI()
        })
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.planetNameList.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let planetInfoVC = PlanetInfoTableViewController()
        
        let viewModelPlanet = PlanetInfoViewModel(name: viewModel?.planetUrlList[indexPath.row] ?? "error")
        
        planetInfoVC.viewModel = viewModelPlanet
        
        navigationController?.pushViewController(planetInfoVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.accessoryType = .disclosureIndicator
        var content = cell.defaultContentConfiguration()
        content.text = viewModel?.planetNameList[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let list = viewModel?.planetNameList else {return}
        if indexPath.row == list.count - 1 {
            viewModel?.requestPlanetList(url: link!, completion: {
                self.updateUI()
            })
            print("yes")
        }
    }
}


