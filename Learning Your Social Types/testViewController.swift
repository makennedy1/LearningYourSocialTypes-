//
//  testViewController.swift
//  Learning Your Social Types
//
//  Created by Kesny Raingsey and Marland Kennedy on 4/25/23.
//

import UIKit

class testViewController: UIViewController {
    
    
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var numberImage: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var textViewResult: UITextView!
    
    
    
    
    let button = UIButton()
    let restartbutton = UIButton(type: .system)
    var imageIndex = 0
    var clickImage = 0

    
    
    var imageDirectory:[String:String] = ["Green1.png":"ambivert",
                                          "Green2.png":"ambivert",
                                          "green3.png":"ambivert",
                                          "blue1.png":"introvert",
                                          "blue2.png":"introvert",
                                          "blue3.png":"introvert",
                                          "orange.png":"extrovert",
                                          "orange1.png":"extrovert",
                                          "orange2.png":"extrovert",
                                          "purple1.png":"introvert",
                                          "purple2.png":"introvert",
                                          "purple3.png":"introvert",
                                          "red.png":"extrovert",
                                          "red1.png":"extrovert",
                                          "red2.png":"extrovert",
                                          "yellow1.png":"ambivert",
                                          "yellow2.png":"ambivert",
                                          "yellow3.png":"ambivert"]
    var overlayImageView: UIImageView?
    var timer: Timer?
    var numberFormatter = NumberFormatter()
    var answer = 6
    var extrovertNum:Int = 0
    var introvertNum:Int = 0
    var ambivertNum:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set up image button
        button.frame = CGRect(x: 0, y: 100, width: 325, height: 325)
        button.center = view.center
        view.addSubview(button)
        
        // set up initial image
        /* button.setImage(UIImage(named: imageNames[imageIndex]), for: .normal)*/
        let imageName = Array(imageDirectory.keys)[imageIndex]
        button.setImage(UIImage(named: imageName), for: .normal)
        
        // start timer to update image every 3 seconds
        /*timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true)*/
        timer = Timer.scheduledTimer(timeInterval: 3,target:self, selector: #selector(UpdateImage), userInfo: nil, repeats:true)
        
        // add target button
        button.addTarget(self, action: #selector(buttonPressed), for:.touchUpInside)
        // set up number of images
        myLabel.textAlignment = .center
        numberImage.textAlignment = .center
        numberFormatter.maximumIntegerDigits = 6
        
    }
    
    
    
    @objc func UpdateImage(){
        imageIndex += 1
        if (imageIndex >= imageDirectory.count)
            
        {
            imageIndex = 0;
            
        }
        let nextImageName = Array(imageDirectory.keys)[imageIndex]
        button.setImage(UIImage(named: nextImageName), for: .normal)
        // add number of each images
        let numImage = Int(imageIndex) + 1
        numberImage.text = "Picture \(numImage)"
        
        
    }
    
    
    @objc func buttonPressed() {
        // perform action when button is tapped
        
        let imageName = Array(imageDirectory.keys)[imageIndex]
        let value = imageDirectory[imageName] ?? "Unknown Value"
        print("The color of the image is -- \(value)")
        // add overlay image view
        let totalProgress = Float(clickImage+1) / Float(answer)
        
        if overlayImageView == nil {
            // set up number of image when selected
            clickImage += 1
            let overlayImage = UIImage(named: "greencheckMark.png")
            overlayImageView = UIImageView(image: overlayImage)
            overlayImageView!.frame = button.bounds
            button.addSubview(overlayImageView!)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.overlayImageView?.removeFromSuperview()
            self.overlayImageView = nil
        }
        // add the progressview of total quiz
        progressView.setProgress(totalProgress, animated: true)
        // add number of each image when seclected
        myLabel.text = "\(clickImage)/6"
        
        // need to click images 30 times to recieve results
        if (clickImage <= 5){
            //clickImage += 1 //increment button clicks each time button is pressed
            //print(clickImage) //Diagnotic print statement
            //record and increment extravertNum, intorvertNum and ambivertNum to send final values to the behaviorImage functions
            switch value {
            case "extrovert": extrovertNum += 1
            case "introvert": introvertNum += 1
            case "ambivert": ambivertNum += 1
            default:print("unknown value")
             }
            
        }
        else{
            
            let resultImage = behaviorImage(extravertVal: extrovertNum, intravertVal: introvertNum, ambivertVal: ambivertNum)
            button.setImage(UIImage(named: resultImage ?? ""), for: .normal)
            timer?.invalidate() //stops timer and ends program
        
           
            let controller = storyboard?.instantiateViewController(withIdentifier: "ResultVC") as! resultViewController
            controller.responses = resultImage!
            controller.modalPresentationStyle = .fullScreen
    
            present(controller, animated: true, completion: nil)
           
            // Add the button to the controller's view
           
            restartbutton.setTitle("restart", for: .normal)
            restartbutton.setTitleColor(.white, for: .normal)
            restartbutton.backgroundColor = UIColor.blue
            restartbutton.addTarget(self, action: #selector(restart), for: .touchUpInside)
            //button.frame = CGRect(x: 400, y: 650, width: 100, height: 50)
            controller.view.addSubview(restartbutton)
            restartbutton.translatesAutoresizingMaskIntoConstraints = false
            restartbutton.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
           // controller.view.addSubview(restartbutton)
            // Position the button towards the bottom of the screen with a margin
            restartbutton.bottomAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true

            // Set the button's frame
            restartbutton.widthAnchor.constraint(equalToConstant: 200).isActive = true
            restartbutton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            // Customize button appearance
           // restartbutton.setTitleColor(.white, for: .normal)
            
        }
         
        func behaviorImage(extravertVal:Int,
                           intravertVal:Int,
                           ambivertVal:Int)->String?{
            
            // create and empty dictionary
            var dictionary = [String:Int]()
            // store values sent from the buttonpressed() functions
            // and store in the dictionary array
            
            dictionary["Extrovert"] = extravertVal
            dictionary["Introvert"] = intravertVal
            dictionary["Ambivert"] = ambivertVal
            
            
            // Sort the values in the from smallest the largest
            let sortedbyvalue = dictionary.sorted{$0.value < $1.value}
            // extract the key from the key-value combination
            let sortedKeys = sortedbyvalue.map {$0.key}
            
            // Because the largest value is now the last value, get the last value an return it to the calling function
            return sortedKeys.last
            
        }
        
    }
    @objc func restart() {
       // Handle button tap event here
       print("function restarted!")
        reStart_App()
   }
    func reStart_App(){
        /// Reset necessary variables and reconfigure initial state
        
        // Reset image index
        imageIndex = 0
        
        // Reset click image counter
        clickImage = 0
        
        // Reset behavior counters
        extrovertNum = 0
        introvertNum = 0
        ambivertNum = 0
        
        // Reset progress view
        progressView.setProgress(0.0, animated: false)
        
        // Reset labels
        myLabel.text = "0/6"
        numberImage.text = ""
        
        // Remove overlay image view
        overlayImageView?.removeFromSuperview()
        overlayImageView = nil
        
        // Reset button image to the initial image
        let initialImageName = Array(imageDirectory.keys)[imageIndex]
        button.setImage(UIImage(named: initialImageName), for: .normal)
        
        // Restart the timer to update images
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(UpdateImage), userInfo: nil, repeats: true)
        
        // Dismiss the current view controller
        self.dismiss(animated: true) {
            // Present a new instance of testViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let initialViewController = storyboard.instantiateInitialViewController() {
                initialViewController.modalPresentationStyle = .fullScreen
                self.present(initialViewController, animated: true, completion: nil)
            }
        }
    }

}

    

