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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutNotePicker.delegate = self
        workoutNotePicker.dataSource = self

        //workoutNotePicker.delegate = self
        //workoutNotePicker.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2//workoutItemListName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return "adsf"//workoutItemListName[row].WorkoutItemName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        /*self.dropdown.isHidden = true
        self.toolBar.isHidden=true
        let cell = workoutItemsTableView.cellForRow(at: indexPathForCell)  as! WorkoutItemTableViewCell
        cell.workoutItem.text = self.workoutItemListName[row].WorkoutItemName
        numberOfWorkoutList[indexPathForCell.row] = self.workoutItemListName[row].WorkoutItemName
 */
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
