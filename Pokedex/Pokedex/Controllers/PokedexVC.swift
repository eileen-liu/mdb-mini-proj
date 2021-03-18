//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2/18/21.
//
import UIKit

class PokedexVC: UIViewController, SelectedTypesProtocol {
    
    let pokemons = PokemonGenerator.shared.getPokemonArray()
    var display: [Pokemon] = []
    var originalDisplay: [Pokemon] = []
    var filteredTypes: [String] = []
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(Displaycell.self, forCellWithReuseIdentifier: Displaycell.reuseIdentifier)
        return collectionView
    }()
    
    let gridToggle: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Grid", for: .normal)
        button.setTitle("Rows", for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let typeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Filter by Type", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    func sendSelectedTypes(data: [String]) {
        filteredTypes = data
    }
    
    private func getPokemon() -> [Pokemon] {
        if filteredTypes.count > 0 {
            var filteredPokemons: [Pokemon] = []
            for pokemon in pokemons {
                var stringArray: [String] = []
                for type in pokemon.types {
                    stringArray.append("\(type)")
                }
                if Set(filteredTypes).isSubset(of: Set(stringArray)) {
                    filteredPokemons.append(pokemon)
                }
            }
            return filteredPokemons
        }
        return pokemons
    }
    
    override func viewWillAppear(_ animated: Bool) {
        display = getPokemon()
        originalDisplay = display
        searchBar.text = ""
        searchBar.endEditing(true)
        collectionView.reloadData()
    }
    
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 150, left: 20, bottom: 0, right: 20))
        
        view.addSubview(gridToggle)
        NSLayoutConstraint.activate([
            gridToggle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            gridToggle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        gridToggle.addTarget(self, action: #selector(handleToggle), for: .touchUpInside)
        
        view.addSubview(typeButton)
        NSLayoutConstraint.activate([
            typeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            typeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
        typeButton.addTarget(self, action: #selector(handleFilters), for: .touchUpInside)
        
        searchBar = UISearchBar.init(frame: CGRect(x: 10, y: 90, width: collectionView.bounds.width, height: 50))
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Pokemon Name"
    }
    
    @objc func handleToggle(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected=false
        } else {
            sender.isSelected=true
        }
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    @objc func handleFilters(sender: UIButton) {
        let vc = FilteringVC()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        present(vc, animated: false, completion: nil)
    }
    
}

extension PokedexVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return display.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = display[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Displaycell.reuseIdentifier, for: indexPath) as! Displaycell
        cell.cellContents = item
        return cell
    }
}

extension PokedexVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !gridToggle.isSelected {
            return CGSize(width: 200, height: 150)
        } else {
            return CGSize(width: 100, height: 150)
        }
    }



    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let poke = display[indexPath.row]
        let vc = DetailsVC()
        vc.poke = poke
        present(vc, animated: true, completion: nil)
    }
}

extension PokedexVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange text: String) {
        display = display.filter({item in
            item.name.localizedCaseInsensitiveContains(text.lowercased())
        })
        
        if text == "" {
            display = originalDisplay
        }
        collectionView.reloadData()
    }
}
