//
//  MenuController.swift
//  mHealth
//
//  Created by Abe Rodriguez on 4/12/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import Foundation
import UIKit

class MenuController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
     //  Create arrays to store menu options 
    let sections  = ["My Goals", "Workouts", "Exercises", "System"]
    let items = [["My Data", "Manage Goals"], ["Start New Workout", "Resume my Workout"], ["Start an Exercise", "Resume my Exercise"], ["Logout"]]
    let images = [["trophy", "trophy"], ["trainers", "news"], ["running", "calendar"], ["power"]]
    
    /* ###########################################################################
        Opens the slideout menu
     ############################################################################*/
    func MenuOpen (navBar: UINavigationBar, tableView: UITableView, view: UIView){

        UITableView.animate(withDuration: 0.5, animations:
        {
            tableView.frame.size.width = 300
            view.transform = CGAffineTransform(translationX: 300, y: 0)
            tableView.dataSource = self
            tableView.delegate = self
        })
    }
    
    /* ###########################################################################
        Closes the slideout menu
     ############################################################################*/
    func MenuClose(navBar: UINavigationBar, tableView: UITableView, view: UIView)
    {
        UITableView.animate(withDuration: 0.5, animations:
            {
                navBar.transform = CGAffineTransform(translationX: 0, y: 0)
                tableView.frame.size.width = 0
                view.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
        // MARK: - Table view data source
    
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sections[section]
        }
    
        func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return sections.count
        }
    //    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    //        return sections
    //    }
    
        /* ###########################################################################
         Function TableView
         if mySearchResults is true then load the newly captured filtered list
         otherwise reload all the data.
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section][indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        switch item {
            
        case "My Data":
            let vc = storyboard.instantiateViewController(withIdentifier: "MyData") 
            //show window
            appDelegate.window?.rootViewController = vc
            let vc2 = self.view?.window?.rootViewController
            vc2?.present(vc, animated: true, completion: nil)
       
        case "Manage Goals":
            let vc = storyboard.instantiateViewController(withIdentifier: "Goals") 
            //show window
            appDelegate.window?.rootViewController = vc
            let vc2 = self.view?.window?.rootViewController
            vc2?.present(vc, animated: true, completion: nil)
        
        case "Start New Workout":
            //  Get the top level view in the hierarchy
            let vc = storyboard.instantiateViewController(withIdentifier: "SelectWorkout") 
            //show window
            appDelegate.window?.rootViewController = vc
            let vc2 = self.view?.window?.rootViewController
            vc2?.present(vc, animated: true, completion: nil)
        
        case "Resume my Workout":
            let vc = storyboard.instantiateViewController(withIdentifier: "ResumeWO")
            //show window
            appDelegate.window?.rootViewController = vc
            let vc2 = self.view?.window?.rootViewController
            vc2?.present(vc, animated: true, completion: nil)
       
        case "Start an Exercise":
            let vc = storyboard.instantiateViewController(withIdentifier: "SelectExcercise") 
            //show window
            appDelegate.window?.rootViewController = vc
            let vc2 = self.view?.window?.rootViewController
            vc2?.present(vc, animated: true, completion: nil)
        
        case "Resume my Exercise":
            let vc = storyboard.instantiateViewController(withIdentifier: "ResumeExVC") 
            appDelegate.window?.rootViewController = vc
            let vc2 = self.view?.window?.rootViewController
            vc2?.present(vc, animated: true, completion: nil)
        
        case "Logout":
            let vc = storyboard.instantiateViewController(withIdentifier: "Login_out")
            //show window
            appDelegate.window?.rootViewController = vc
            let vc2 = self.view?.window?.rootViewController
            vc2?.present(vc, animated: true, completion: nil)
        
        default:
            print("Not a Valid Menu Option ")
            
            
        }
    }
    
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
}
