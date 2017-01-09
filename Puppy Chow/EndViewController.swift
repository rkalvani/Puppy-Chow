//
//  EndViewController.swift
//  Puppy Chow
//
//  Created by rkalvani on 9/30/16.
//  Copyright © 2016 rkalvani. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    @IBOutlet weak var endingLabel: UILabel!
    var scoreClass = ScoreClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        endingLabel.text = "The puppies are so happy! You caught \(scoreClass.score) treats!"
    }
}
