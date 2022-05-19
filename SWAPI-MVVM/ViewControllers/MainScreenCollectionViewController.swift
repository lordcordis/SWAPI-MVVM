enum resultType {
    case dictionary
    case people
    case starship
    case vehicle
    case species
    case films
    case planets
}


class MainScreenCollectionViewModel: MainScreenCollectionViewModelType {
    

    
    private let mainUrlString = "https://swapi.dev/api/"
    
    
    var sections = [String]()
    var urls = [String]()
    
    
    init(completion: @escaping ()->Void) {
        ClosureHTTPManager.shared.get(urlString: "https://swapi.dev/api/") { Result in
            
            switch Result {
            case .success(let data):
                let res = MainScreenCollectionViewModel.jsonDecodeToDictionary(data: data, resultType: .dictionary)
                
                guard let keys = res?.keys.sorted() else {return}
                keys.forEach { key in
                    self.sections.append(key)
                }
                
                guard let urls = res?.values.sorted() else {return}
                urls.forEach { url in
                    self.urls.append(url)
                }
//
//
                print(self.sections)
                print(self.urls)
                completion()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
        }
    }
    
    static func jsonDecodeToDictionary(data: Data, resultType: resultType) -> Dictionary<String, String>? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(Dictionary<String, String>.self, from: data)
            return decoded
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}


//static func jsonDecodeToType(data: Data, resultType: resultType) -> Dictionary<String, String>? {
//    let decoder = JSONDecoder()
//    do {
//        let decoded = try decoder.decode(Dictionary<String, String>.self, from: data)
//        return decoded
//    } catch {
//        print(error.localizedDescription)
//        return nil
//    }
//}


protocol MainScreenCollectionViewModelType {
    
}

import UIKit
class MainScreenCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var viewModel: MainScreenCollectionViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SWAPI"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 250, height: 65)
        layout.scrollDirection = .vertical
        
        let myCollectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(MainScreenCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.backgroundColor = UIColor.systemBackground
        self.view.addSubview(myCollectionView)
        
        viewModel = MainScreenCollectionViewModel(completion: {
            DispatchQueue.main.async {
                myCollectionView.reloadData()
            }
        })
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.sections.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MainScreenCell
        myCell.backgroundColor = .systemPink
        myCell.layer.cornerRadius = 10
        myCell.headlineLabel.text = viewModel?.sections[indexPath.row].uppercased()
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        guard let urlString = viewModel?.urls[indexPath.row] else {return}
        switch viewModel?.sections[indexPath.row] {
        
        case "planets":
            let planetsVC = PlanetsMainTableViewController()
            planetsVC.link = urlString
            planetsVC.type = .planets
            navigationController?.pushViewController(planetsVC, animated: true)
        case "films":
            print("films m8")
        case "people":
            print("people m8")
        case "species":
            print("species m8")
        case "vehicles":
            print("veh m8")
        case "starships":
            print("aw em starships")
        case .none:
            print("ow")
        case .some(_):
            print("aw")
        }
    
        

    }
    
}
