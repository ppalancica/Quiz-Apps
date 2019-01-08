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
    var isQuestionAnswered: Bool = false
    
    lazy var answerOptions = questionAnswerOptions["answerOptions"] as! [String]
    lazy var correctAnswer = questionAnswerOptions["correctAnswer"] as! String
    lazy var questionId = questionAnswerOptions["questionId"] as! String
    
    private var selectedIndex: Int?
    
    let defaults = UserDefaults.standard

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
        
        if isQuestionAnswered {
            answersTableView.allowsSelection = false // answersTableView.isUserInteractionEnabled = false
            submitAnswerButton.isHidden = true
            
            let userSubmittedAnswer = defaults.value(forKey: questionId) as! String
            let resultMessage = (userSubmittedAnswer == correctAnswer) ? "CORRECT" : "INCORRECT"
            
            resultLabel.text = resultMessage
            showAlert(title: "Your answer is:", message: resultMessage)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isQuestionAnswered {
            let userSubmittedAnswer = defaults.value(forKey: questionId) as! String
            
            if let userSubmittedAnswerIndex = answerOptions.firstIndex(of: userSubmittedAnswer) {
                let indexPath = IndexPath(row: userSubmittedAnswerIndex, section: 0)
                let cellToBeSelected = answersTableView.cellForRow(at: indexPath)
                cellToBeSelected?.setSelected(true, animated: true)
            }
        }
    }
    
    @IBAction func onCancelButtonTap(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmitAnswerButtonTap(_ sender: Any) {
        if let selectedIndex = selectedIndex {
            let selectedAnswer = answerOptions[selectedIndex]
            let resultMessage = (selectedAnswer == correctAnswer) ? "CORRECT" : "INCORRECT"
            
            resultLabel.text = resultMessage
            showAlert(title: "Your answer is:", message: resultMessage)
            
            answersTableView.allowsSelection = false // answersTableView.isUserInteractionEnabled = false
            submitAnswerButton.isEnabled = false
            
            defaults.set(selectedAnswer, forKey: questionId)
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

extension AnswerOptionsViewController {
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(alertAction)
        present(alertVC, animated: true, completion: nil)
    }
}
