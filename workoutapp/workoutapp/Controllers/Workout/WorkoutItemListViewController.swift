//
//  WorkoutItemListViewController.swift
//  workoutapp
//
//  Created by BSH on 2018. 3. 15..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import UIKit

class WorkoutItemListViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate,UIToolbarDelegate,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var Bt: UIButton!
    @IBOutlet weak var workoutName: UITextField!
    @IBOutlet weak var workoutTextbox: UITextField!
    var workoutItemListName = WorkoutItemDB().getWorkoutItemNameList()
    var workoutItemsList = ["-"]
   // @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var dropdown: UIPickerView!
    @IBOutlet weak var workoutItemsTableView: UITableView!
    var workoutTempTextbox: UITextField!
    var WorkoutNameString = String()
    var WorkoutIdString = String()
    var BtText = String()
    var selectedWorkoutItemId = Int32()
    var selectedWorkoutItemName = String()
    var userWorkoutItemNameTextField :UITextField?
    var indexPathForCell = IndexPath();
    override func viewDidLoad() {
        super.viewDidLoad()
        dropdown.delegate = self
        dropdown.dataSource = self
        workoutTextbox.delegate = self
        workoutItemsTableView.delegate=self
        workoutItemsTableView.dataSource=self
  //      toolBar.delegate=self
        toolBar.delegate=self
        Bt.setTitle(BtText, for: UIControlState.normal)
        workoutName.text = WorkoutNameString
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(donePicker))
        let addWorkoutItemButton = UIBarButtonItem(title: "Add Workout Item", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(addWorkoutItem))
        toolBar.setItems([cancelButton,addWorkoutItemButton], animated: false)
        
        //Long Press
        let recognizer:UILongPressGestureRecognizer=UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        dropdown.addGestureRecognizer(recognizer)
        
 
    }
        
  //      let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
  //      toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
      //  toolBar.sizeToFit()
       /*
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
 */
    /*
        let doneButton = UIBarButtonItem(barButtonSystemItem:.done,target:nil, action:nil)
        toolBar.setItems([doneButton], animated: false)
        //toolBar.isUserInteractionEnabled = true
        
        workoutTextbox.inputView = dropdown
        workoutTextbox.inputAccessoryView = toolBar
        }
  */
    
    
    @IBAction func AddWorkoutItmesBt(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workoutItemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkoutItemTableViewCell
       cell.workoutItem.text=workoutItemsList[indexPath.row]
     //   var cellTextField = self.view.viewWithTag(101) as? UITextField
        cell.workoutItem.delegate = self
        workoutTempTextbox = cell.workoutItem
        workoutTempTextbox.delegate = self
      //  indexPathForCell = indexPath
        return cell
    }
    
    @IBAction func addWorkoutItem(_ sender: Any) {
        // create the alert
        let alert = UIAlertController(title: "Workout Item Name", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: userWorkoutItemNameTextField)
        
        // add cancel action (button)
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.default, handler: nil))
        
        // add okay action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: self.okayBt_workoutItemadd))
      
        // show the alert
        self.present(alert, animated: true, completion: nil)

    }
    
    func okayBt_workoutItemadd(alert: UIAlertAction)
    {
        if(userWorkoutItemNameTextField?.text==""||userWorkoutItemNameTextField?.text==nil)
        {
            // create the alert
            let alert = UIAlertController(title: "Workout Item", message: "Please enter workouItem name.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let workoutItemModel = WorkoutItemModel.init(WorkoutItemId: 0, WorkoutItemName: (userWorkoutItemNameTextField?.text)!)
            WorkoutItemDB().insertWorkoutItem(workoutItemModel: workoutItemModel)
            self.workoutItemListName = WorkoutItemDB().getWorkoutItemNameList()
            self.dropdown.reloadAllComponents()
        }
    }
    func userWorkoutItemNameTextField(textField:UITextField)
    {
            userWorkoutItemNameTextField = textField
            userWorkoutItemNameTextField?.placeholder="workout item name"

    }
    @IBAction func createBt(_ sender: Any) {
        if BtText=="Create"
        {
            let workoutModel = WorkoutModel.init(WorkoutId: 0, WorkoutName: workoutName.text!)
            WorkoutDB().insertWorkout(workoutModel: workoutModel)
        }
        else if BtText=="Save"
        {
            let workoutModel = WorkoutModel.init(WorkoutId: Int32(WorkoutIdString)!, WorkoutName: workoutName.text!)
            WorkoutDB().updateWorkout(workoutModel: workoutModel)
        }
    }
    @objc func donePicker() {
        self.dropdown.isHidden = true
        self.toolBar.isHidden=true
        workoutTextbox.resignFirstResponder()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workoutItemListName.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return workoutItemListName[row].WorkoutItemName
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       self.workoutTextbox.text = self.workoutItemListName[row].WorkoutItemName
        self.dropdown.isHidden = true
        self.toolBar.isHidden=true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if (textField == self.workoutTextbox)
        {
            self.dropdown.isHidden = false
            self.toolBar.isHidden=false
        }
        let cell = workoutItemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPathForCell) as! WorkoutItemTableViewCell
      //  cell.workoutItem.text=workoutItemsList[indexPathForCell.row]
        if(textField == self.workoutTempTextbox)
        {
            self.dropdown.isHidden = false
            self.toolBar.isHidden=false
        }
        
        
    }
    @IBAction func longPress(_ recognizer: UILongPressGestureRecognizer) {
       
        let point = recognizer.location(in: dropdown)
        
        if recognizer.state == UIGestureRecognizerState.began
        {
         var index = self.dropdown.selectedRow(inComponent: 0)
         selectedWorkoutItemId = self.workoutItemListName[index].WorkoutItemId
         selectedWorkoutItemName = self.workoutItemListName[index].WorkoutItemName
          //  let index = dropdown.indexPathForRow(at: point)
          //  self.selectedWorkoutItemId = Int32(workoutItemListName[index!.row])
           createAlert()
            //if(self.delete==true)
            // {
            //  let timerModel = TimerModel.init(TimerId:Int32(timerListName[indexPath].TimerId)!,TimerName: timerListName[indexPath].TimerName,NumberOfSets : Int32(timerListName[indexPath].NumberOfSets)!, HighInetensity: timerListName[indexPath].HighInetensity, LowIntensity: timerListName[indexPath].LowIntensity)
            //TimerDB().deleteTimer(TimerId:timerId)
            //}
        }
            //cell.isHighlighted
        else {
            return
        }
    }
    func deleteWorkoutItem(alert: UIAlertAction)
    {
          let alert = UIAlertController(title: "Do you want to delete "+selectedWorkoutItemName+" ?", message: "If you click 'YES', it will permanently delete.", preferredStyle: .alert)
         
         alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
         (action) in
         WorkoutItemDB().deleteWorkoutItem(WorkoutItemId: self.selectedWorkoutItemId)
         self.workoutItemListName = WorkoutItemDB().getWorkoutItemNameList()
         self.dropdown.reloadAllComponents()
         //  self.delete = true
         }))
         alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
         (action) in
         //  self.delete = false
         alert.dismiss(animated: true, completion: nil)
         }))
         self.present(alert, animated: true)
        
    }
    func updateWorkoutItem(alert: UIAlertAction)
    {
        selectedWorkoutItemName = (userWorkoutItemNameTextField?.text)!
        WorkoutItemDB().updateWorkoutItem(workoutItemModel: WorkoutItemModel(WorkoutItemId:selectedWorkoutItemId, WorkoutItemName: selectedWorkoutItemName))
        self.workoutItemListName = WorkoutItemDB().getWorkoutItemNameList()
        self.dropdown.reloadAllComponents()
    }
    func createAlert()
    {

        
        // create the alert
        let alert = UIAlertController(title: "Workout Item Name", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler: userWorkoutItemNameTextField)
        userWorkoutItemNameTextField?.text = selectedWorkoutItemName
 
        // add cancel action (button)
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.default, handler: nil))
        
        // add delete action (button)
        alert.addAction(UIAlertAction(title: "DELETE", style: UIAlertActionStyle.default, handler: self.deleteWorkoutItem))
        
        // add okay action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: self.updateWorkoutItem))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
 
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

