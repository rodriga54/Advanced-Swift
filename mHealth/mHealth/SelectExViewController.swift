//
//  SelectExViewController.swift
//  mHealth
//
//  Created by Abe Rodriguez on 4/11/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import UIKit

//  Global Variables
var exData:[String] = []
var pickerCat:[String] = []
var pickerName:[String] = []
var excerc = [Excercises]()
var pickerData = [Excercises]()
var coreData = [Exercise]()
var exList: Dictionary <String, Dictionary<String,Dictionary<String,String>>> = Dictionary()

class SelectExViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    //  Create outlets
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet var myView: UIView!
    @IBOutlet weak var ExcerciseTF: UITextField!
    @IBOutlet weak var exTime: UITextField!
    @IBOutlet weak var segController: UISegmentedControl!
    @IBOutlet weak var category: UILabel!
    
    //  Local Arrays
    var key = ""
    let picker = UIDatePicker()
    var exPicker = UIPickerView()
    let menu = MenuController()
    // Create an optional
    var excer = [Exercise]()
    var coreData = [Exercise]()
    var oldcat = ""
    var menuActive = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        GetData()
        exPicker.dataSource = self
        exPicker.delegate = self
        ExcerciseTF.inputView = exPicker
        //exPicker.selectedRow(inComponent: 0)
        SelectTime()
    }
    /*
        action outlet adds user selected exercise to core data
     */
    @IBAction func AddEx(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let excer = Exercise(context: context)
        excer.exerciseName = ExcerciseTF?.text
        excer.exerciseKey = key
        excer.exerciseCat = category.text
        excer.exerciseDate = Date() as NSDate
        excer.exerciseTime = exTime?.text
        print(exTime)
        //  Save the data to core data (database)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
       //navigationController!.popViewController(animated: true)
        let exerciseTableViewController = ExerciseTableViewController(nibName: "ExerciseTableViewController", bundle: nil)
        navigationController?.pushViewController(exerciseTableViewController, animated: true)
        
    }
    /*
     Toggle the slide out menu
    */
    @IBAction func menuBtn(_ sender: Any) {
                if menuActive{
                    menu.MenuOpen(navBar: naviBar, tableView: myTableView, view: myView)
           
                    self.menuActive = false
                }else{
                    menu.MenuClose(navBar: naviBar, tableView: myTableView, view: myView)
                    self.menuActive = true
                }
    }
    /* ###########################################################################
     Function: SelectDate ()
     The function adds a new owner to the database via POST
     ############################################################################*/
    func SelectTime ()
    {
        picker.datePickerMode = .countDownTimer
        picker.minuteInterval = 15
        // Create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Add a bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector (Done))
        
        // assigning picker to text field
        exTime.inputAccessoryView = toolbar
        ExcerciseTF.inputAccessoryView = toolbar
        exTime.inputView = picker
        
        toolbar.setItems([doneButton], animated: false)
    }
    
    /* ###########################################################################
     Function: Done ()
     The function adds a new owner to the database via POST
     ############################################################################*/
    func Done ()
    {
        // format date
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .medium
        dateformatter.dateFormat = "HH:mm"
        
        if exTime.text == "00:00" || exTime.text == nil {
            exTime.text = "00:15"
        }else {
            
            exTime.text = dateformatter.string(from: picker.date)
        }
        self.view.endEditing(true)
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    /*
        Allow user to delete exercises from core dara
    */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let cd = excer[indexPath.row]
            context.delete(cd)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                excer = try context.fetch(Exercise.fetchRequest())
            }
            catch{
                print("Print failed")
            }
            myTableView.reloadData()
        }
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category.text = pickerData[row].exCat
        ExcerciseTF.text = pickerData[row].exName
        key = pickerData[row].exKey
        //Excercise.text = Array(pickerData.values)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (component==0) {
        return pickerData[row].exCat
    }
        return pickerData[row].exName  // [row].exName//[row].exName
    }
    /*
        Segmented controller to display video, images, texr
    */
    @IBAction func segControl(_ sender: Any) {
        
        switch segController.selectedSegmentIndex
        {
            //  Videos
        case 0:
            ErrAlert()
            segController.selectedSegmentIndex = 2
            
            //  Images
        case 1:
            ErrAlert()
            segController.selectedSegmentIndex = 2
           
        default:
            break;
        }
    }
    /*
        Downloads JSON and stores data into an array 
    */
    func GetData ()
    {
            if let url = URL(string: "http://students.cs.niu.edu/~exerciseapp/getexercise.php") {
                let session = URLSession.shared
                let task = session.dataTask(with: url) {(data, response, error) in
                    let httpResponse = response as? HTTPURLResponse
                    if httpResponse?.statusCode != 200 {
                        // Perform some error handling, other status codes should be // handled as well
                        print("HTTP Error: status code \(httpResponse!.statusCode)")
                    } else if (data == nil && error != nil) { print("Error: No data downloaded")
                    } else {
                        print("JSON data downloaded")
                        do
                        {
                            let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                            //loading the JSON data into Exercise array
                            
                            for ex in json
                            {
                                let object = (ex as AnyObject)
                                let pk = object["pk"] as! String
                                let name = object["name"] as! String
                                let cat = object["category"] as! String
                                pickerData.append(Excercises(exKey: pk, exName: name, exCat: cat))
                                ////////////////////////
                                if cat != self.oldcat {
                                    pickerCat.append(cat)
                                }
                                self.oldcat = cat
                            }
                            // call to the main thread for execution.
                            DispatchQueue.main.async(execute:
                                {
                            })// the end of Grand Central Dispatch
                        }
                        catch
                        {
                            print("error trying to convert data to JSON")
                        }
                    }
                }
                task.resume()
            } else {
                print("Invalid URL")
            }
    }
    
    /*
     Display message to user that option selected not available on this version of app.
    */
    func ErrAlert()
    {
        /////////////////////////////////////////////////////////////
        let alertController = UIAlertController(title: "Error", message: "Option not avialable on the version of the App.", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
        ///////////////////////////////////////////////////////////
    }
}
