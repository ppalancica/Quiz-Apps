//
//  AnswerOptionsViewController.swift
//  Basic-Quiz
//
//  Created by Pavel Palancica on 1/3/19.
//  Copyright © 2019 I Dev TV. All rights reserved.
//

import UIKit

class AnswerOptionsViewController: UIViewController {
    
    var questionAnswerOptions: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(questionAnswerOptions)
    }
    
    @IBAction func onCancelButtonTap(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
