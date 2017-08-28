//
//  ResumeExViewController.swift
//  mHealth
//
//  Created by Abe Rodriguez on 4/6/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import UIKit

//  Global Variables
var subName1 = ""
var subCat1 = ""
var subTime1 = ""
var subKey1 = ""

class ResumeExViewController: UIViewController {
    //  Creating outlets to labels and buttons
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var submitKey: UILabel!
    @IBOutlet weak var subName: UILabel!
    @IBOutlet weak var subCat: UILabel!
    @IBOutlet weak var subTime: UILabel!
    /*
        Complete action button shall post to database when an exercise has been completed.  The core data shall update item as completed and show the user that exercise has been completed.
    */
    @IBAction func Complete(_ sender: Any) {
    }
    //  Declare Variables
    var image:UIImage!
    var playtoggle = true
    var time = Timer()
    var fractions: Int = 0
    var seconds: Int = 0
    var minutes : Int = 0
    var hours : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Populating test fields with data selected.
        submitKey.text = subKey1
        subName.text = subName1
        subCat.text = subCat1
        subTime.text = subTime1
    }
    
    /*
        PlayPause action button shall give the user the ability to use
     */
    @IBAction func PlayPause(_ sender: Any) {
        //  toggle the play button and change image to the pause.
        if playtoggle
        {
        image = UIImage(named:"Pause-1")
        time = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ResumeExViewController.updateTimer), userInfo: nil, repeats: true)
        play.setImage(image, for: .normal)
            playtoggle = false
        }
        else
        {
        //  Stop the timer
        time.invalidate()
        //  Change play image to a pause image
        image = UIImage(named:"Play-1")
        play.setImage(image, for: .normal)
        playtoggle = true
        }
    }// End of PlayPause()
    
    /*
        basic function of timer. 
        May need to figure out how to store time upon app exit and 
        how to kepp it running on the back thread?
     */
    func updateTimer()
    {
        fractions += 1
        if fractions == 100
        {
            seconds += 1
            fractions = 0
        }
        if seconds == 60
        {
            minutes+=1
            seconds = 0
        }
        if minutes == 60
        {
            hours+=1
            minutes = 0
        }
        //  Track the fractions
        let frac = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        //  Track the seconds
        let sec = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        //  Track the minutes
        let min = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        //  Track the hours
        let hr = hours > 9 ? "\(hours)" : "0\(hours)"
        //  Display results to string
        let timerstring = "\(min):\(sec).\(frac)"
        //  display results to label
        timer.text = timerstring
    }// End of updateTimer()
}// End of ResumeExViewController()
