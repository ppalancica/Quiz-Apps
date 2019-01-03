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
        "How many planets are in the Solar System?",
        "How many continents are on Planet Earth?",
        "What is the capital of United States?",
        "What is the capital of Russia?",
        "Largest country that resides on 2 continents?"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension QuestionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = questions[indexPath.row]
        return cell
    }
}
