//
//  StatsVC.swift
//  Meet the Member
//
//  Created by Michael Lin on 1/18/21.
//
import UIKit

class StatsVC: UIViewController {
    
    // MARK: STEP 13: StatsVC Data
    // When we are navigating between VCs (e.g MainVC -> StatsVC),
    // since MainVC doesn't directly share its instance properties
    // with other VCs, we often need a mechanism of transferring data
    // between view controllers. There are many ways to achieve
    // this, and I will show you the two most common ones today. After
    // carefully reading these two patterns, pick one and implement
    // the data transferring for StatsVC.
    
    // Method 1: Implicit Unwrapped Instance Property
    //
    // Check didTapStats in MainVC.swift on how to use it.
    //
    // Explanation: This method is fairly straightforward: you
    // declared a property, which will then be populated after
    // the VC is instantiated. As long as you remember to
    // populate it after each instantiation, the implicit forced
    // unwrap will not result in a crash.
    //
    // Pros: Easy, no boilerplate required
    //
    // Cons: Poor readability. Imagine if another developer wants to
    // use this class, unless it's been well-documented, they would
    // have no idea that this variable needs to be populated.
    
    // Method 2: Custom initializer
    var last3: [[String]]!
    var beststreak: Int!
    var dataWeNeedExample2: String
    init(data: String) {
        dataWeNeedExample2 = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    // Check didTapStats in MainVC.swift on how to use it.
    //
    // Explanation: This method creates a custom initializer which
    // takes in the required data. This pattern results in a cleaner
    // initialization and is more readable. Compared with method 1
    // which first initialize the data to nil then populate, in this
    // method the data is directly initialized in the init so there's
    // no need for unwrapping of any kind.
    //
    // Pros: Clean. Null safe.
    //
    // Cons: Doesn't work with interface builder (storyboard)
    
    // MARK: >> Your Code Here <<
    
    // MARK: STEP 14: StatsVC UI
    // You know the drill. Initialize the UI components, add subviews,
    // and create constraints.
    //
    // Note: You cannot use self inside these closures because they
    // happens before the instance is fully initialized. If you want
    // to use self, do it in viewDidLoad.
    
    // MARK: >> Your Code Here <<
    let streakLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let questionsLabels: [UILabel] = {
        return (0..<3).map { index in
            let label = UILabel()
            label.textColor = .darkGray
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.tag = index
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: >> Your Code Here <<
        streakLabel.text = ("Longest Streak: \(beststreak!)")
        for i in 0..<(min(last3.count, 3)) {
            let question = last3[last3.count-1-i]
            let label = questionsLabels[i]
            
            label.text = question[0]
            if question[1] == "correct" {
                label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            } else {
                label.textColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }
            
        }
        view.addSubview(streakLabel)
        
        
        NSLayoutConstraint.activate([
            streakLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            streakLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            streakLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
        ])
        view.addSubview(questionsLabels[0])
               view.addSubview(questionsLabels[1])
               view.addSubview(questionsLabels[2])

               NSLayoutConstraint.activate([
                questionsLabels[0].widthAnchor.constraint(equalToConstant: 150),
                questionsLabels[0].topAnchor.constraint(equalTo: streakLabel.topAnchor, constant: 50),
                questionsLabels[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
                questionsLabels[1].widthAnchor.constraint(equalToConstant: 150),
                questionsLabels[1].topAnchor.constraint(equalTo: questionsLabels[0].bottomAnchor, constant: 15),
                questionsLabels[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
                questionsLabels[2].widthAnchor.constraint(equalToConstant: 150),
                questionsLabels[2].topAnchor.constraint(equalTo: questionsLabels[1].bottomAnchor, constant: 15),
                questionsLabels[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
                
               ])
     
    }

}
