//
//  MainViewController.swift
//  mHealth
//
//  Created by Abe Rodriguez on 4/2/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var myView: UIView!
    
    @IBOutlet weak var naviBar: UINavigationBar!
    var menuView = MenuViewController()
    
    var menuactive = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
//        let defaults = UserDefaults.standard
//        let pin = defaults.string(forKey: "")
//        if pin == nil {
            //performSegue(withIdentifier: "Main", sender: self)
//        }
    }

    
    
    @IBAction func MenuToggle(_ sender: Any) {
       
//        self.MenuTableView.backgroundColor = UIColor.darkGray
//        self.MenuTableView.backgroundColor = UIColor.lightText
        if menuactive{
            UITableView.animate(withDuration: 0.5, animations: {
             // self.menuView.MenuTableView.frame.size.width = 300
                self.myView.transform = CGAffineTransform(translationX: 300, y: 0)
                //self.naviBar.transform = CGAffineTransform(translationX: 300, y: 0)
//                self.MenuTableView.backgroundColor = UIColor.darkGray
//                self.MenuTableView.backgroundColor = UIColor.lightText
                self.menuactive = false
                //self.performSegue(withIdentifier: "MenufromMain", sender: self)
            })
        }else{
            UITableView.animate(withDuration: 0.5, animations: {
//                self.MenuTableView.frame.size.width = 0
                
                
                //self.MenuTableView.backgroundColor = UIColor.clear
                self.myView.transform = CGAffineTransform(translationX: 0, y: 0)
                //self.naviBar.transform = CGAffineTransform(translationX: 0, y: 0)
                self.menuactive = true
                self.performSegue(withIdentifier: "MenufromMain", sender: self)
            })
             //performSegue(withIdentifier: "MenufromMain", sender: self)
        }
        
    }
}
