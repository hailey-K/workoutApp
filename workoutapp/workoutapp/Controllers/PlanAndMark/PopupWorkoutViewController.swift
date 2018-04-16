//
//  PopupWorkoutViewController.swift
//  workoutapp
//
//  Created by hyerim on 2018. 3. 15..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import UIKit

class PopupWorkoutViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var workoutNotePicker: UIPickerView!
    let workoutNoteDB = WorkoutNoteDB()
    var workoutNoteList = [WorkoutNoteModel]()
    var previousSelected = String()
    var selectedItemIndex = 0;
    var selectedDate = String()
    var tempWorkoutNoteList = [String]()
    var workoutNoteId = Int32()
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutNotePicker.delegate = self
        workoutNotePicker.dataSource = self
        tempWorkoutNoteList.append("None")
        previousSelected = "None"
        workoutNoteList = workoutNoteDB.getWorkoutListWithSelecedItem(selectedDate: selectedDate)
        var notNone = false
        for i in 0..<workoutNoteList.count {
            tempWorkoutNoteList.append(workoutNoteList[i].workoutName)
            if(workoutNoteList[i].isSelected == true){
                selectedItemIndex = i
                previousSelected = workoutNoteList[i].workoutName
                workoutNoteId = workoutNoteList[i].noteWorkoutId
                notNone = true
            }
        }
        if notNone == true
        {
            workoutNotePicker.selectRow(selectedItemIndex+1, inComponent: 0, animated: false)
        }
        else
        {
             workoutNotePicker.selectRow(0, inComponent: 0, animated: false)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func closePopup(_ sender: Any) {
        //Save item
        print(self.selectedItemIndex)
        
        //insert or update
        if(selectedItemIndex != 0)
        {
            if(workoutNoteList.count > 0){
                var workoutNoteItem = workoutNoteList[self.selectedItemIndex-1]
                workoutNoteItem.date = selectedDate
                workoutNoteDB.insertOrUpdateWorkoutNote(workoutNote: workoutNoteItem)
                
                if let popVC = presentingViewController as? PopupViewController {
                    popVC.workoutBt.setTitle(workoutNoteItem.workoutName, for: .normal)
                    popVC.workoutNoteCheckBt.setImage(UIImage(named:"unCheckmark"), for: .normal)
                    popVC.workoutNoteCheckBt.isSelected = false
                    popVC.workoutName = workoutNoteItem.workoutName
                    WorkoutNoteDB().updateWorkoutNoteForMark(mark:0,noteWorkoutId:workoutNoteId)
                }
            }
        }
        //delete if exist
        else
        {
        //    var workoutNoteItem = workoutNoteList[self.selectedItemIndex]
         //   workoutNoteItem.date = selectedDate
            workoutNoteDB.deleteWorkoutNote(noteWorkoutId:workoutNoteId)
            
            if let popVC = presentingViewController as? PopupViewController {
                popVC.workoutBt.setTitle("Create/Edit workout", for: .normal)
                popVC.workoutNoteCheckBt.setImage(UIImage(named:"unCheckmark"), for: .normal)
                popVC.workoutNoteCheckBt.isSelected = false
                popVC.workoutName = ""
                WorkoutNoteDB().deleteWorkoutNote(noteWorkoutId: workoutNoteId)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tempWorkoutNoteList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return tempWorkoutNoteList[row]
      //  return workoutNoteList[row].workoutName//workoutItemListName[row].WorkoutItemName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedItemIndex = row
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
