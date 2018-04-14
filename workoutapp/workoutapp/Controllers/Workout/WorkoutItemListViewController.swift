//
//  WorkoutItemListViewController.swift
//  workoutapp
//
//  Created by hyerim on 2018. 3. 15..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import UIKit

class WorkoutItemListViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate,UIToolbarDelegate,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var Bt: UIButton!
    @IBOutlet weak var workoutName: UITextField!
    var workoutItemListName = WorkoutItemDB().getWorkoutItemNameList()
    var workoutItemsList=[WorkoutListModel]()
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var dropdown: UIPickerView!
    @IBOutlet weak var workoutItemsTableView: UITableView!
    var workoutTempTextbox:UITextField!
    var WorkoutNameString = String()
    var WorkoutIdString = String()
    var numberOfWorkoutList = [String]()
    var BtText = String()
    var selectedWorkoutItemId = Int32()
    var selectedWorkoutItemName = String()
    var userWorkoutItemNameTextField :UITextField?
    var indexPathForCell = IndexPath()
    var indexPathForDropdown = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        dropdown.delegate = self
        dropdown.dataSource = self
        workoutItemsTableView.delegate=self
        workoutItemsTableView.dataSource=self
        toolBar.delegate=self
        Bt.setTitle(BtText, for: UIControlState.normal)
        workoutName.text = WorkoutNameString

        //create new workout id
        if(WorkoutIdString != "")
        {
            workoutItemsList = WorkoutListDB().getWorkoutListNameList(WorkoutId: Int32(WorkoutIdString)!)
            if(workoutItemsList.count != 0)
            {
                for i in 0..<workoutItemsList.count
                {
                   numberOfWorkoutList.append(WorkoutItemDB().getWorkoutItemName(workoutItemId:workoutItemsList[i].WorkoutItemId))
                }
            }
            else
            {
                numberOfWorkoutList.append("")
            }
        }
        else
        {
          numberOfWorkoutList.append("")
        }
   
      
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(donePicker))
        let addWorkoutItemButton = UIBarButtonItem(title: "Add Workout Item", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(addWorkoutItem))
        toolBar.setItems([cancelButton,addWorkoutItemButton], animated: false)
        
        //Long Press
        let recognizer:UILongPressGestureRecognizer=UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        dropdown.addGestureRecognizer(recognizer)
        
 
    }
    
    
    @IBAction func AddWorkoutItmesBt(_ sender: Any) {
        numberOfWorkoutList.append("")
        self.workoutItemsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return numberOfWorkoutList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workoutItemsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkoutItemTableViewCell
        cell.workoutItem.delegate = self
        cell.workoutItemIndexPath = indexPath
        cell.workoutItem.text = numberOfWorkoutList[indexPath.row]
        print(cell.workoutItem.text! + "tableview cell for row at")
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
    func removeEmptyTextField()->[String]
    {
        var tmpNumberOfWorkoutList = [String]()
        for i in 0..<numberOfWorkoutList.count
        {
            if numberOfWorkoutList[i] == ""
            {
                tmpNumberOfWorkoutList.append(numberOfWorkoutList[i])
            }
        }
        return tmpNumberOfWorkoutList
    }
    @IBAction func createBt(_ sender: Any) {
        if BtText=="Create"
        {
            var haveEmptyTextField = removeEmptyTextField()
            if(haveEmptyTextField.count == 0)
            {
                let workoutModel = WorkoutModel.init(WorkoutId: 0, WorkoutName: workoutName.text!)
                WorkoutDB().insertWorkout(workoutModel: workoutModel)
                CreateOrUpdateWorkoutItems(type:"Create",workoutId:WorkoutDB().getWorkoutId(WorkoutName:workoutName.text!))
            }
            else
            {
                // create the alert
                let alert = UIAlertController(title: "Workout", message: "Please fill all of the empty textbox.", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
        else if BtText=="Save"
        {
            var haveEmptyTextField = removeEmptyTextField()
            if(haveEmptyTextField.count == 0)
            {
                let workoutModel = WorkoutModel.init(WorkoutId: Int32(WorkoutIdString)!, WorkoutName: workoutName.text!)
                WorkoutDB().updateWorkout(workoutModel: workoutModel)
                CreateOrUpdateWorkoutItems(type:"Update",workoutId:Int32(WorkoutIdString)!)
            }
            else
            {
                // create the alert
                let alert = UIAlertController(title: "Workout", message: "Please fill all of the empty textbox.", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    func CreateOrUpdateWorkoutItems(type:String,workoutId:Int32)
    {
        if(type=="Create")
        {
            for i in 0..<numberOfWorkoutList.count
            {
               var workoutItemId = WorkoutItemDB().getWorkoutItemId(workoutName:numberOfWorkoutList[i])
               WorkoutListDB().insertWorkoutList(workoutListModel:WorkoutListModel.init(WorkoutListId: 0, WorkoutItemId: workoutItemId, WorkoutId: workoutId))
            }
        }
        else if(type=="Update")
        {
            //delete workout list for the workoutId
            WorkoutListDB().deleteWorkoutList(WorkoutId:workoutId)
           
            //insert all new workout list for workoutId
            for i in 0..<numberOfWorkoutList.count
            {
               var workoutItemId = WorkoutItemDB().getWorkoutItemId(workoutName:numberOfWorkoutList[i])
               WorkoutListDB().insertWorkoutList(workoutListModel:WorkoutListModel.init(WorkoutListId: 0, WorkoutItemId: workoutItemId, WorkoutId: workoutId))
            }
        }
    }
    @objc func donePicker() {
        self.dropdown.isHidden = true
        self.toolBar.isHidden=true
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
        self.dropdown.isHidden = true
        self.toolBar.isHidden=true
        let cell = workoutItemsTableView.cellForRow(at: indexPathForCell)  as! WorkoutItemTableViewCell
        cell.workoutItem.text = self.workoutItemListName[row].WorkoutItemName
        numberOfWorkoutList[indexPathForCell.row] = self.workoutItemListName[row].WorkoutItemName
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
       let cells = self.workoutItemsTableView.visibleCells as! Array<WorkoutItemTableViewCell>
        
        for cell in cells {
            if(textField == cell.workoutItem)
            {
            self.dropdown.isHidden = false
            self.toolBar.isHidden=false
            indexPathForCell = cell.workoutItemIndexPath
            workoutTempTextbox = cell.workoutItem
            break
            }
        }
    }
    @IBAction func longPress(_ recognizer: UILongPressGestureRecognizer) {
       
        let point = recognizer.location(in: dropdown)
        
        if recognizer.state == UIGestureRecognizerState.began
        {
         var index = self.dropdown.selectedRow(inComponent: 0)
         selectedWorkoutItemId = self.workoutItemListName[index].WorkoutItemId
         selectedWorkoutItemName = self.workoutItemListName[index].WorkoutItemName
           createAlert()
        }
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
         }))
         alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
         (action) in
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

}

