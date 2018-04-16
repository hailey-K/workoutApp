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
    var selectedItemIndex = 0;
    var selectedDate = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutNotePicker.delegate = self
        workoutNotePicker.dataSource = self
        workoutNoteList = workoutNoteDB.getWorkoutListWithSelecedItem(selectedDate: selectedDate)
        
        for i in 0..<workoutNoteList.count {
            if(workoutNoteList[i].isSelected == true){
                selectedItemIndex = i
            }
        }
        workoutNotePicker.selectRow(selectedItemIndex, inComponent: 0, animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func closePopup(_ sender: Any) {
        //Save item
        print(self.selectedItemIndex)
        if(workoutNoteList.count > 0){
            var workoutNoteItem = workoutNoteList[self.selectedItemIndex]
            workoutNoteItem.date = selectedDate
            workoutNoteDB.insertOrUpdateWorkoutNote(workoutNote: workoutNoteItem)
            
            if let popVC = presentingViewController as? PopupViewController {
                popVC.workoutBt.setTitle(workoutNoteItem.workoutName, for: .normal)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workoutNoteList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return workoutNoteList[row].workoutName//workoutItemListName[row].WorkoutItemName
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
