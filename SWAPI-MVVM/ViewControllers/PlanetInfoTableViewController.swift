//
//  PlanetInfoTableViewController.swift
//  SWAPI-MVVM
//
//  Created by Wheatley on 11.05.2022.
//

import Foundation
import UIKit

class PlanetInfoTableViewController: UITableViewController {
    
    var viewModel: PlanetInfoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        title = viewModel?.name
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection() ?? 1
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.numberOfSections() ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "planetCell")
        var config = cell.defaultContentConfiguration()
        config.text = viewModel?.name ?? "error"
        
        cell.contentConfiguration = config
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}
