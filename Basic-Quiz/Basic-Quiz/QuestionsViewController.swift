//
//  QuestionsViewController.swift
//  Basic-Quiz
//
//  Created by Pavel Palancica on 1/3/19.
//  Copyright © 2019 I Dev TV. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var questionsTableView: UITableView!
    
    var questions = [
        "0": [
            "question": "How many planets are in the Solar System?",
            "answerOptions": ["7", "8", "9"],
            "correctAnswer": "9"
        ],
        "1": [
            "question": "How many continents are on Planet Earth?",
            "answerOptions": ["6", "7", "8"],
            "correctAnswer": "7"
        ],
        "2": [
            "question": "What is the capital of United States?",
            "answerOptions": ["Washington", "Washington, D.C.", "Columbia"],
            "correctAnswer": "Washington, D.C."
        ],
        "3": [
            "question": "What is the capital of Russia?",
            "answerOptions": ["Kremlin", "Saint Petersburg", "Moscow"],
            "correctAnswer": "Moscow"
        ],
        "4": [
            "question": "Largest country that resides on 2 continents?",
            "answerOptions": ["Turkey", "Egypt", "Russia"],
            "correctAnswer": "Russia"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = questionsTableView.indexPathForSelectedRow {
            questionsTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAnswerOptions" {
            let answerOptionsVC = segue.destination as! AnswerOptionsViewController
            let selectedIndexPath = sender as! IndexPath
            let selectedIndex = selectedIndexPath.row
            let questionInfo = questions[String(selectedIndex)]!
            let question = questionInfo["question"] as! String
            let answerOptions = questionInfo["answerOptions"] as! [String]
            let correctAnswer = questionInfo["correctAnswer"] as! String
            
            answerOptionsVC.questionAnswerOptions = [
                "question": question,
                "answerOptions": answerOptions,
                "correctAnswer": correctAnswer
            ]
        }
    }
}

extension QuestionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.numberOfLines = 0
        let questionInfo = questions[String(indexPath.row)]!
        cell.textLabel?.text = questionInfo["question"] as? String
        return cell
    }
}

extension QuestionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToAnswerOptions", sender: indexPath)
    }
}
