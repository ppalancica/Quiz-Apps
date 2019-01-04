//
//  AnswerOptionsViewController.swift
//  Basic-Quiz
//
//  Created by Pavel Palancica on 1/3/19.
//  Copyright © 2019 I Dev TV. All rights reserved.
//
// https://medium.com/@kahseng.lee123/how-to-solve-the-most-common-interface-problems-when-adapting-apps-ui-for-iphone-x-44c0f3c80d84
// https://www.hackingwithswift.com/articles/5/how-to-adopt-ios-11-user-interface-changes-in-your-app

import UIKit

class AnswerOptionsViewController: UIViewController {
    
    var questionAnswerOptions: NSDictionary!
    
    lazy var answerOptions = questionAnswerOptions["answerOptions"] as! [String]
    
    private var selectedIndex: Int?

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answersTableView: UITableView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var submitAnswerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(questionAnswerOptions)
        
        questionLabel.text = questionAnswerOptions["question"] as? String
        resultLabel.text = ""
        submitAnswerButton.isEnabled = false
    }
    
    @IBAction func onCancelButtonTap(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmitAnswerButtonTap(_ sender: Any) {
        if let selectedIndex = selectedIndex {
            let selectedAnswer = answerOptions[selectedIndex]
            let correctAnswer = questionAnswerOptions["correctAnswer"] as! String
            
            if selectedAnswer == correctAnswer {
                resultLabel.text = "CORRECT"
            } else {
                resultLabel.text = "INCORRECT"
            }
            
            answersTableView.isUserInteractionEnabled = false
            submitAnswerButton.isEnabled = false
        }
    }
}

extension AnswerOptionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.numberOfLines = 0
        let answer = answerOptions[indexPath.row]
        cell.textLabel?.text = answer
        return cell
    }
}

extension AnswerOptionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        submitAnswerButton.isEnabled = true
    }
}
