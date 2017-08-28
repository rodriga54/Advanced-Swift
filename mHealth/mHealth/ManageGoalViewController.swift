//
//  ManageGoalViewController.swift
//  mHealth
//
//  Created by Abe Rodriguez on 4/15/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import UIKit

class ManageGoalViewController: UIViewController {

    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet var myView: UIView!
    let menu = MenuController()
    let manage = true
    var menuActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if manage {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        //let top = UIApplication.shared.keyWindow?.rootViewController
            let vc2 = self.view?.window?.rootViewController
            
            /////////////////////////////////////////////////////////////
            let alertController = UIAlertController(title: "Error", message: "Menu selection is not avialable on the version of the App.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button");
            }
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
            ///////////////////////////////////////////////////////////
            //  Get the top level view in the hierarchy
            let vc = storyboard.instantiateViewController(withIdentifier: "SelectWorkout")
            //show window
            appDelegate.window?.rootViewController = vc
            vc2?.present(vc, animated: true, completion: nil)
        }
    }

        @IBAction func menuBtn(_ sender: Any) {
            if menuActive{
                menu.MenuOpen(navBar: naviBar, tableView: myTableView, view: myView)
                
                self.menuActive = false
            }else{
                menu.MenuClose(navBar: naviBar, tableView: myTableView, view: myView)
                self.menuActive = true
                
            }
        }
}
