//
//  Displaycell.swift
//  Pokedex
//
//  Created by Eileen Liu on 3/15/21.
//
import Foundation
import UIKit

class Displaycell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: Displaycell.self)
    
    var cellContents: Pokemon? {
            didSet {
                guard let pokemonName = cellContents else { return }
                guard let url = URL(string: pokemonName.imageUrl) else { return }
                guard let data = try? Data(contentsOf: url) else { return }
                let image: UIImage = UIImage(data: data)!
                imageView.image = image
                idName.text = String(pokemonName.id) + " " + String(pokemonName.name)
            }
        }
        
        private let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
        }()
        
        private let idName: UILabel = {
            let label = UILabel()
            label.adjustsFontSizeToFitWidth = true
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 10)
            label.textColor = .black
            return label
        }()
    
        override init(frame: CGRect) {
           super.init(frame: frame)
           contentView.layer.borderWidth = 0.5
           contentView.layer.borderColor = UIColor.black.cgColor
           
           contentView.addSubview(idName)
           contentView.addSubview(imageView)

           NSLayoutConstraint.activate([
               idName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
               imageView.heightAnchor.constraint(equalToConstant: 150),
               imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
               imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           ])
       }

        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
