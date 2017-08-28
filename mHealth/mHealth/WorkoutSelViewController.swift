//
//  WorkoutSelViewController.swift
//  mHealth
//
//  Created by Abe Rodriguez on 4/13/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import UIKit

class WorkoutSelViewController: UIViewController {

    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet var myView: UIView!
    let menu = MenuController()
    var menuActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func menu(_ sender: Any) {
        if menuActive{
            menu.MenuOpen(navBar: naviBar, tableView: myTableView, view: myView)

            self.menuActive = false
        }else{
            menu.MenuClose(navBar: naviBar, tableView: myTableView, view: myView)
            self.menuActive = true
            
        }
    }
}
