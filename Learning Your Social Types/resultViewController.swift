//
//  resultViewController.swift
//  Learning Your Social Types
//
//  Created by Kesny Raingsey on 4/25/23.
//

import UIKit

class resultViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var textViewResult: UITextView!
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var colorResult: UILabel!
    var responses = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTest()
        

        // Do any additional setup after loading the view.
    }
    
    //result test
    func resultTest() {
    if responses == "Introvert" {
        resultImage.image = UIImage(named: "Introvert")
        colorResult.textColor = UIColor.blue
        colorResult.text = ("Your personality's colors are “BLUE” and “PURPLE”.")
        textViewResult.textColor = UIColor.purple
        textViewResult.text = ("You tend to enjoy spending extra time alone with your favorite hobby. You probably prefer to work alone rather than work as a group. You may don’t like parties with crowds of people and often feel exhausted after spending time with people you don’t know well. ")
     } else if responses == "Extrovert" {
         resultImage.image = UIImage(named: "Extrovert")
         colorResult.textColor = UIColor.red
         colorResult.text = ("Your personality's colors are “RED” and “ORANGE”.")
         textViewResult.textColor = UIColor.orange
         textViewResult.text = ("You tend to be outgoing and sociable. You enjoy spending time around people and being the center of attention. You may enjoy parties, and social events with crowds of people and feel comfortable having conversations with groups of people.")
     } else if responses == "Ambivert" {
         resultImage.image = UIImage(named: "Ambivert")
         colorResult.textColor = UIColor.green
         colorResult.text = ("Your personality's colors are “GREEN” and “YELLOW”.")
         textViewResult.textColor = UIColor.yellow
         textViewResult.text = ("You tend to have both alone times and are sociable. You enjoy spending time with others but you also enjoy having time alone with yourself. You don’t mind conversing with a group of people you know, but you probably prefer to avoid conversations with people You do not know well.")
     } else {
     
     }
     
    }
     
    
}
