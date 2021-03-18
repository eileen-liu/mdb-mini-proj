//
//  DetailsVC.swift
//  Pokedex
//
//  Created by Eileen Liu on 3/15/21.
//
import Foundation
import UIKit

class DetailsVC: UIViewController {
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = ""
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true

        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    var poke: Pokemon?
    var details: [String: Any]!
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        do {
            details = try poke?.allProperties()
            for (property, value) in details {
                if value is [PokeType] {
                    let name = value as! [PokeType]
                    contentLabel.text! += "\(property.capitalized): "
                    for i in 0..<name.count {
                        contentLabel.text! += "\(name[i].rawValue)"
                        if i == name.count - 1 {
                            contentLabel.text! += "\n"
                        }
                    }
                } else {
                    contentLabel.text! += "\(property.capitalized): \(value)\n"
                }
            }
        } catch {
            print("error")
        }

        if let url: URL = URL(string: self.poke!.imageUrlLarge) {
            if let image = try? Data(contentsOf: url) {
                self.imageView.image = UIImage(data: image)
            }
        }
        titleLabel.text = poke?.name
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.topAnchor, constant: 50),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

protocol Loopable {
    func allProperties() throws -> [String: Any]
}

extension Loopable {
    func allProperties() throws -> [String: Any] {

        var result: [String: Any] = [:]

        let mirror = Mirror(reflecting: self)

        for (property, value) in mirror.children {
            guard let property = property, !property.contains("image"), property != "name" else {
                continue
            }
            if let range = property.range(of: "special") {
                let property = "Special " + property[range.upperBound...]
                result[property] = value
            } else {
                result[property] = value
            }
        }

        return result
    }
}
