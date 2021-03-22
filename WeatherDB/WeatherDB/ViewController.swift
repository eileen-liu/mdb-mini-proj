//
//  ViewController.swift
//  WeatherDB
//
//  Created by Michael Lin on 3/20/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        WeatherRequest.shared.weather(for: "London") { result in
            switch result {
            case .success(let weather):
                print(weather)
            case .failure(_):
                print("Failed")
            }
            
        }
    }


}

