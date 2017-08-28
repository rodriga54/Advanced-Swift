//
//  MenuViewController.swift
//  mHealth
//
//  Created by Abe Rodriguez on 4/2/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{

    //  create outlet to my MenuTableView
    @IBOutlet weak var MenuTableView: UITableView!
    //  Create arrays to store menu options
    let sections  = ["My Goals", "Workouts", "Exercises", "System"]
    let items = [["View Data", "Manage Goals"], ["Start New Workout", "Resume my Workout"], ["Start an Exercise", "Resume my Exercise"], ["Logout"]]
    let images = [["trophy", "trophy"], ["trainers", "news"], ["running", "calendar"], ["power"]]
    //  boolean initialized to true
    var menuactive = true

    override func viewDidLoad() {
        super.viewDidLoad()
        MenuTableView.delegate = self
        MenuTableView.dataSource = self
        self.MenuTableView.frame.size.width = 300
    }


    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    /* ###########################################################################
     Function TableView
     Returns: The count of items in section
     ############################################################################*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items[section].count
    }

    /* ###########################################################################
     Function TabelView (CellForRoaAt)
     loads content of the filtered or full list to the table view
     ############################################################################*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let allItems = items[indexPath.section][indexPath.row]
        let image = images[indexPath.section][indexPath.row]
        cell.textLabel?.text = allItems
        cell.imageView?.image = UIImage(named: image)
        return cell
    }
}

