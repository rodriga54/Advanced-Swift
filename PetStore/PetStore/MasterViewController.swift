//------------------------------------------------------------------------------
//  MasterViewController.swift
//  PetStore
//
//  Created by Abe Rodriguez on 3/6/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//------------------------------------------------------------------------------
/*  The purpose of the master view controller is to display the Owners of pets.
        Owners can be added
 
 */

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet var ownerTableView: UITableView!
    var firstNames: [String] = []
    var lastNames: [String] = []

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    let dataRequest = PetDatabase()
    let urlString = "http://www.jorjabrown.us/petstore/api/owners/list"
    var newFName: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ownerTableView.dataSource = self
        ownerTableView.delegate = self
//        NotificationCenter.default.addObserver(self, selector: #selector(loadView), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        DownloadGet(getList: urlString)

        // This will be called whenever adding a new owner and pet.
        //########################################################
        //dataRequest.UpLoadPost()
        
        
        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        ownerTableView.reloadData()
    }// End of viewDidLoad

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // inserting object to database
    func insertNewObject(_ sender: Any) {
        let context = self.fetchedResultsController.managedObjectContext
        let newEvent = Event(context: context)
             
        // If appropriate, configure the new managed object.
        newEvent.timestamp = NSDate()

        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    //---------------------------------------------------------------------
    // MARK: - Segues
    //---------------------------------------------------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
            let object = self.fetchedResultsController.object(at: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        // Adding new seguw for the adding of owners and pets
        //if segue.identifier == "addin" {}
        
    }
    //---------------------------------------------------------------------
    // MARK: - Table View
    //---------------------------------------------------------------------
    override func numberOfSections(in tableView: UITableView) -> Int {
        return firstNames.count
//        return self.fetchedResultsController.sections?.count ?? 0
    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let sectionInfo = self.fetchedResultsController.sections![section]
//        return sectionInfo.numberOfObjects
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let event = self.fetchedResultsController.object(at: indexPath)
//        self.configureCell(cell, withEvent: event)
        
        print(firstNames)
        print("this was printed in tableView")
        //firstNames[indexPath.row]
         cell.textLabel!.text = "🐶 \(firstNames[indexPath.row])"
        ownerTableView.reloadData()
        return cell
    }

//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }

//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let context = self.fetchedResultsController.managedObjectContext
//            context.delete(self.fetchedResultsController.object(at: indexPath))
//                
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

    func configureCell(_ cell: UITableViewCell, withEvent event: Event) {
        cell.textLabel!.text = "👨‍🎤👩‍🎤 \(firstNames)"
    }
    //---------------------------------------------------------------------
    // MARK: - Fetched results controller
    //---------------------------------------------------------------------
    var fetchedResultsController: NSFetchedResultsController<Event> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             // Replace this implementation with code to handle the error appropriately.
             // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController<Event>? = nil

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            case .insert:
                self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            default:
                return
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                self.configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
            case .move:
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }

    
    func do_table_refresh(fName: Array<Any>)
    {
        let ownerList = UIApplication.shared.delegate as? PetDatabase
        //ownerList?.lastNames
        newFName = fName as! [String]
        print(fName)
        print(newFName)
        
//        OperationQueue.main.addOperation ({
//            //self.viewDidLoad()
//            self.ownerTableView.reloadData()
//        })
        
        
//            DispatchQueue.main.async
//                {
                    //self.tableView.reloadData()
        
                self.ownerTableView.reloadData()
//                }
    }
    
    //------------------------------------------------------------------------------
    //
    //
    //------------------------------------------------------------------------------
    
    func DownloadGet (getList: String)
    {
        
        
        if let url = URL(string: getList) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                let httpResponse = response as? HTTPURLResponse
                if httpResponse?.statusCode != 200 {
                    // Perform some error handling, other status codes should be // handled as well
                    print("HTTP Error: status code \(httpResponse!.statusCode)")
                } else if (data == nil && error != nil) { print("Error: No data downloaded")
                } else {
                    print("JSON data downloaded")
                    
                    
                    do
                    {
                        
                        //DispatchQueue.async{
                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        //let posts = json[""] as? [[String: Any]] ?? []
                        print(json)
                        //print(posts)
                        for name in 0...json.count-1{
                            
                            let aObject = json[name] as! [String : AnyObject]
                            //                    if let fname = name as? String {
                            self.firstNames.append(aObject["fname"] as! String)
                            self.lastNames.append(aObject["lname"] as! String)
                            //                        names.append(name)
                            //print(fname)
                            //                )
                            //                    DispatchQueue.main.async
                            //                        {
                            //                        print(self.firstNames)
                            //                        print(self.lastNames)
                            ////                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                            //
                            //
                            //                        }
                        }
//                        let mTableView = MasterViewController()
//                        mTableView.do_table_refresh(fName: self.firstNames)
                        print(self.firstNames)
                        print(self.lastNames)
                        //return firstNames
                        //}// end of async dispatch
                        
                        
                        
                                        DispatchQueue.main.async(execute: {
//                                                self.mTableView.do_table_refresh()
                                            self.ownerTableView.reloadData()
                                            })// the end of Grand Central Dispatch
                    }
                    catch
                    {
                        print("error trying to convert data to JSON")
                        return
                    }
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
        //return firstNames
    }// End of DownloadGet
    
    
    
    
    
    
    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */
}

