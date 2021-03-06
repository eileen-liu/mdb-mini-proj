//
//  MainVC.swift
//  Meet the Member
//
//  Created by Michael Lin on 1/18/21.
//
import Foundation
import UIKit

class MainVC: UIViewController {
    
    // Create a property for our timer, we will initialize it in viewDidLoad
    var timer: Timer?
    var time = 0
    var points = 0
    var last3 = [[String]]()
    var correct: String?
    var currstreak = 0
    var beststreak = 0
    var stop = false

    
    // MARK: STEP 8: UI Customization
    // Customize your imageView and buttons. Run the app to see how they look.
    
    let imageView: UIImageView = {
        let view = UIImageView()
        
        // MARK: >> Your Code Here <<
        view.translatesAutoresizingMaskIntoConstraints = false
                return view
    }()
    
    let buttons: [UIButton] = {
            // Creates 4 buttons, each representing a choice.
            // Use ..< or ... notation to create an iterable range
            // with step of 1. You can manually create these using the
            // stride() method.
            return (0..<4).map { index in
                let button = UIButton()

                // Tag the button its index
                button.tag = index
                
                // MARK: >> Your Code Here <<
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = .systemGray
                
                button.translatesAutoresizingMaskIntoConstraints = false
                
                return button
            }
            
        }()
        
        let scoreLabel: UILabel = {
            let label = UILabel()
            label.textColor = .darkGray
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 27, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false

            return label
        }()

    let pauseButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Pause", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: STEP 12: Stats Button
    // Follow the examples you've learned so far, initialize a
    // stats button used for going to the stats screen, add it
    // as a subview inside the viewDidLoad and set up the
    // constraints. Finally, connect the button's with the @objc
    // function didTapStats.
    
    // MARK: >> Your Code Here <<
    let statsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Stats", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        // Create a timer that calls timerCallback() every one second
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
                
        // If you don't like the default presentation style,
        // you can change it to full screen too! This way you
        // will have manually to call
        // dismiss(animated: true, completion: nil) in order
        // to go back.
        //
        // modalPresentationStyle = .fullScreen
        
        // MARK: STEP 7: Adding Subviews and Constraints
        // Add imageViews and buttons to the root view. Create constraints
        // for the layout. Then run the app with ???+r. You should see the image
        // for the first question as well as the four options.
        
        // MARK: >> Your Code Here <<
        view.addSubview(imageView)
                NSLayoutConstraint.activate([
                            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
                            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
                            imageView.heightAnchor.constraint(equalToConstant: 200)
                        ])
                
                view.addSubview(buttons[0])
                view.addSubview(buttons[1])
                view.addSubview(buttons[2])
                view.addSubview(buttons[3])

                NSLayoutConstraint.activate([
                    buttons[0].widthAnchor.constraint(equalToConstant: 150),
                    buttons[0].topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
                    buttons[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
                    buttons[1].widthAnchor.constraint(equalToConstant: 150),
                    buttons[1].topAnchor.constraint(equalTo: buttons[0].bottomAnchor, constant: 15),
                    buttons[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
                    buttons[2].widthAnchor.constraint(equalToConstant: 150),
                    buttons[2].topAnchor.constraint(equalTo: buttons[1].bottomAnchor, constant: 15),
                    buttons[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
                    buttons[3].widthAnchor.constraint(equalToConstant: 150),
                    buttons[3].topAnchor.constraint(equalTo: buttons[2].bottomAnchor, constant: 15),
                    buttons[3].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125)
                ])

                view.addSubview(scoreLabel)
                view.addSubview(statsButton)
                NSLayoutConstraint.activate([
                    scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                    scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    statsButton.topAnchor.constraint(equalTo: buttons[3].bottomAnchor, constant: 10),
                    statsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125),
                    statsButton.widthAnchor.constraint(equalToConstant: 150)
                ])

        view.addSubview(pauseButton)
        NSLayoutConstraint.activate([
            pauseButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pauseButton.leadingAnchor.constraint(equalTo: scoreLabel.trailingAnchor, constant: 150),
        ])
        
        getNextQuestion()
        

        
        
        // MARK: STEP 10: Adding Callback to the Buttons
        // Use addTarget to connect the didTapAnswer function to the four
        // buttons touchUpInside event.
        //
        // Challenge: Try not to use four separate statements. There's a
        // cleaner way to do this, see if you can figure it out.
        
        // MARK: >> Your Code Here <<
        for i in 0...buttons.count-1 {
            buttons[i].addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        }
        
        pauseButton.addTarget(self, action: #selector(didTapPause(_:)), for: .touchUpInside)
        
        
        
        // MARK: STEP 12: Stats Button
        // Follow instructions at :49
        
        // MARK: >> Your Code Here <<
        statsButton.addTarget(self, action: #selector(didTapStats(_:)), for: .touchUpInside)
    }
    
    // What's the difference between viewDidLoad() and
    // viewWillAppear()? What about viewDidAppear()?
    override func viewWillAppear(_ animated: Bool) {
        // MARK: STEP 15: Resume Game
        // Restart the timer when view reappear.
        
        // MARK: >> Your Code Here <<
        pauseButton.setTitle("Pause", for: .normal)
        stop = false
        updateScore()
        time = 0
    }
    
    func getNextQuestion() {
        // MARK: STEP 5: Connecting to the Data Model
        // Read the QuestionProvider class in Utils.swift. Get an instance of
        // QuestionProvider.Question and use a *guard let* statement to conditionally
        // assign it to a constant named question. Return if the guard let
        // condition failed.
        //
        // After you are done, take a look at what's in the
        // QuestionProvider.Question type. You will need that for the
        // following steps.
        
        // MARK: >> Your Code Here <<
        updateScore()
                guard let question = QuestionProvider().getNextQuestion() else {return}
                correct = question.answer
        
        // MARK: STEP 6: Data Population
        // Populate the imageView and buttons using the question object we obtained
        // above.
        
        // MARK: >> Your Code Here <<
        buttons[0].setTitle(question.choices[0], for: .normal)
                        buttons[1].setTitle(question.choices[1], for: .normal)
                        buttons[2].setTitle(question.choices[2], for: .normal)
                        buttons[3].setTitle(question.choices[3], for: .normal)
                
                for i in 0...buttons.count-1 {
                    if question.choices[i] == correct {
                        buttons[i].tag = 1
                    } else {
                        buttons[i].tag = 0
                    }
                }
                imageView.image = question.image
                
            }
    
    // This function will be called every one second
    @objc func timerCallback() {
        // MARK: STEP 11: Timer's Logic
        // Complete the callback for the one-second timer. Add instance
        // properties and/or methods to the class if necessary. Again,
        // the instruction here is intentionally vague, so read the spec
        // and take some time to plan. you may need
        // to come back and rework this step later on.
        
        // MARK: >> Your Code Here <<
        
        if stop == false {
            if time == 5 {
                getNextQuestion()
                currstreak = 0
                time = 0
            } else {
                time += 1
            }
        }
    }
    
    
    @objc func didTapAnswer(_ sender: UIButton) {
        // MARK: STEP 9: Buttons' Logic
        // Add logic for the 4 buttons. Take some time to plan what
        // you are gonna write. The 4 buttons should be able to share
        // the same callback. Add instance properties and/or methods
        // to the class if necessary. The instruction here is
        // intentionally vague as I'd like you to decide what you
        // have to do based on the spec. You may need to come back
        // and rework this step later on.
        //
        // Hint: You can use `sender.tag` to identify which button is tapped
        
        // MARK: >> Your Code Here <<
        //if correct
            if sender.tag == 1 {
                points += 1
                currstreak += 1
                last3.append([sender.title(for: .normal)!, "correct"])
                sender.setTitleColor(.systemGreen, for: .normal)
                if currstreak > beststreak {
                    beststreak = currstreak
                }
                
            } else {
                currstreak = 0

                sender.setTitleColor(.systemRed, for: .normal)
                last3.append([sender.title(for: .normal)!, "false"])
            }
            
            self.time = -1
            _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
                sender.setTitleColor(.black, for: .normal)
                self.getNextQuestion()
            }
        
    }
    
    
    
    @objc func didTapStats(_ sender: UIButton) {
        
        let vc = StatsVC(data: "Hello")
        
        
        vc.beststreak = beststreak
        vc.last3 = last3
        
        vc.modalPresentationStyle = .fullScreen
        
        // MARK: STEP 13: StatsVC Data
        // Follow instructions in StatsVC. You also need to invalidate
        // the timer instance to pause game before going to StatsVC.
        
        // MARK: >> Your Code Here <<
        stop = false
        pauseButton.setTitle("Go", for: .normal)
        stop = true
        
        vc.modalPresentationStyle = .fullScreen
        vc.view.backgroundColor = .white
        present(vc, animated: true, completion: nil)
    }
    
    @objc func didTapPause(_ sender: UIButton) {
        if stop {
            pauseButton.setTitle("Pause", for: .normal)
            time = 0
            stop = false

        } else {
            pauseButton.setTitle("Go", for: .normal)
            stop = true
        }
    }
    
    func updateScore() {
        scoreLabel.text = "Score: \(points)"
    }
    
    // MARK: STEP 16:
    // Read the spec again and run the app. Did you cover everything
    // mentioned in it? Play around it for a bit, see if you can
    // uncover any bug. Is there anything else you want to add?
}
