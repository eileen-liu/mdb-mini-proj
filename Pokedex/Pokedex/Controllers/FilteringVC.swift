//
//  FilteringVC.swift
//  Pokedex
//
//  Created by Eileen Liu on 3/15/21.
//
import Foundation
import UIKit

protocol SelectedTypesProtocol {
    func sendSelectedTypes(data: [String])
}

class FilteringVC: UIViewController {
    let types = UIStackView()
    var filteredTypes: [String] = []
    var delegate: SelectedTypesProtocol? = nil
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitle("Back", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        types.axis = .vertical
        types.distribution = .equalSpacing
        types.translatesAutoresizingMaskIntoConstraints = false
        
        for val in PokeType.allCases {
            let button = UIButton()
            button.setTitleColor(.black, for: .normal)
            button.setTitleColor(.green, for: .selected)
            button.titleLabel?.font = .systemFont(ofSize: 20)
            button.setTitle(val.rawValue, for: .normal)
            if filteredTypes.contains(val.rawValue) {
                button.isSelected = true
            }
            button.addTarget(self, action: #selector(filterType), for: .touchUpInside)
            types.addArrangedSubview(button)
        }
        
        view.addSubview(types)
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            types.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            types.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            types.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            backButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 25),
        ])
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    @objc func goBack(sender: UIButton) {
        if delegate != nil  {
            dismiss(animated: true, completion: nil)
            delegate?.sendSelectedTypes(data: filteredTypes)
        }
                
    }
    @objc func filterType(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            if filteredTypes.contains(sender.titleLabel!.text!) {
                filteredTypes.remove(at: filteredTypes.firstIndex(of: sender.titleLabel!.text!)!)
            }
            
        } else {
            sender.isSelected = true
            filteredTypes.append(sender.titleLabel!.text!)
        }
    }
}
