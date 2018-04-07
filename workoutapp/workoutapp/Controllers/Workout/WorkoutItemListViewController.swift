//
//  WorkoutItemListViewController.swift
//  workoutapp
//
//  Created by BSH on 2018. 3. 15..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import UIKit

class WorkoutItemListViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate,UIToolbarDelegate{
 
    
   
    //@IBOutlet weak var dropdown: UIPickerView!
    @IBOutlet weak var workoutTextbox: UITextField!
    let workoutItemListName = ["+","-"]
   
    @IBOutlet weak var dropdown: UIPickerView!
    @IBOutlet weak var toolbar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        dropdown.delegate = self
        dropdown.dataSource = self
        workoutTextbox.delegate = self
        toolbar.delegate=self
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(donePicker))
        self.toolbarItems = [doneButton]
    //   toolbar.setItems([doneButton], animated: false)
 
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
    @objc func donePicker() {
        
        workoutTextbox.resignFirstResponder()
        
    }
 */
    @IBAction func addWorkoutItem(_ sender: Any) {
        // create the alert
        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        /*let alert = UIAlertController(title: "Do you want to delete the timer?", message: "If you click 'YES', it will permanently delete.", preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
            (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
     */
        print("asdfasd button clicked")
    }
    
    @objc func donePicker() {
       
        // create the alert
        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)

        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return workoutItemListName.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return workoutItemListName[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.workoutTextbox.text = self.workoutItemListName[row]
        self.dropdown.isHidden = true
        self.toolbar.isHidden=true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.workoutTextbox
        {
            self.dropdown.isHidden = false;
            self.toolbar.isHidden=false
        }
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

