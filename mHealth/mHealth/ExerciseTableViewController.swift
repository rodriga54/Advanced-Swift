//
//  ExerciseTableViewController.swift
//  mHealth
//
//  Created by Abe Rodriguez on 5/2/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import UIKit
import CoreData
/* ###########################################################################
    Class:  EXTableViewCell
            Label Outlets
 ############################################################################ */
class EXTableViewCell: UITableViewCell {
    // creating and linking outlet labels

    @IBOutlet weak var nameEx: UILabel!
    @IBOutlet weak var catEx: UILabel!
    @IBOutlet weak var keyEx: UILabel!
}
/* ###########################################################################
    Class:  ExerciseTableViewController
 ############################################################################ */
class ExerciseTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var myTableView: UITableView!
    var key = ""
    var ex = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.reloadData()
    }

    /* ###########################################################################
     functonality adds swipe left to delete item form core data and reload
     table view to main view comtroller.
     ############################################################################ */
    override func viewWillAppear(_ animated: Bool) {
        getData()
        myTableView.reloadData()
    }
    
    /* ###########################################################################
     functonality adds swipe left to delete item form core data and reload
     table view to main view comtroller.
     ############################################################################ */
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            ex = try context.fetch(Exercise.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /* ###########################################################################
     returns the quantity in the array
     ############################################################################*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ex.count
    }
    
    /* ###########################################################################
     Function:  tableView editingStyle
                gives the user the ability to swipe left to get an option to delete item.
     ############################################################################ */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let cd = ex[indexPath.row]
            context.delete(cd)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                ex = try context.fetch(Exercise.fetchRequest())
            }
            catch{
                print("Print failed")
            }
            myTableView.reloadData()
        }
    }
    
    /* ###########################################################################
     Function:  tableView cellForRowAt 
                runs through the data and displays on the table view
     Returns:   cell
     ############################################################################*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EXTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EXTableViewCell
        let data: Exercise

            data = ex[indexPath.row]
        // Populate the tableview
        cell.nameEx?.text = "🏌️‍♀️ \(data.exerciseName!)"
        cell.catEx?.text = "🥇 \(data.exerciseCat!)"
        cell.keyEx?.text = " \(data.exerciseKey!)"
        return cell
    }
    
    /* ###########################################################################
     Function:  tableView DidSelectRowAt
                stores the values in for the user selected row.
     ############################################################################ */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data: Exercise

        data = ex[indexPath.row]
        
         subName1 = data.exerciseName!
         subCat1 = data.exerciseCat!
         subTime1 = data.exerciseTime!
         subKey1 = data.exerciseKey!
        //  Goes to the selectEx segue
        performSegue(withIdentifier: "selectEx", sender: self)
    }
    /* ###########################################################################
     Function: prepare(for segue: UIStoryboardSegue, sender: Any?)
                Passes values through the segue
     ############################################################################ */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectEx" {
            //let edit =  segue.destination as! ResumeExViewController
            
            // Pass the selected object to the new view controller.
            let indexPath = self.myTableView.indexPathForSelectedRow!
            let data = ex[indexPath.row]
            
            subName1 = data.exerciseName!
            subCat1 = data.exerciseCat!
            subTime1 = data.exerciseTime!
            subKey1 = data.exerciseKey!
        }
    }
}
