//
//  PopupViewController.swift
//  workoutapp
//
//  Created by hyerim on 2018. 3. 15..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var workoutBt: UIButton!
    @IBOutlet weak var noteBt: UIButton!
    var noteString = String()
    var noteContent = String()
    var workoutString = String()
    var selectedDate = String()
    var noteId = Int32()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedDate != "")
        {
            var noteModel = NoteDB().getNoteList(date:selectedDate)
            var workoutNoteModelList = WorkoutNoteDB().getWorkoutListWithSelecedItem(selectedDate:selectedDate)
            if(noteModel.count != 0)
            {
                noteString = noteModel[0].title
                noteContent = noteModel[0].contents
                noteBt.setTitle(noteString, for: .normal)
                noteId = noteModel[0].noteId
            }
            
            var workoutName = ""
            
            if(workoutNoteModelList.count > 0){
                for i in 0..<workoutNoteModelList.count{
                    if(workoutNoteModelList[i].isSelected == true){
                        workoutName = workoutNoteModelList[i].workoutName
                    }
                }
            }
            
            if(workoutString != "" && workoutString != nil)
            {
                workoutBt.setTitle(workoutString, for: UIControlState.normal)
            }
            
            if(workoutName != ""){
                workoutBt.setTitle(workoutName, for: UIControlState.normal)
            }
        }
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //note popup
        if segue.identifier == "popupForNotesSegue"{
            let popupNoteVC = segue.destination as! PopupNoteViewController
            popupNoteVC.selectedDate = selectedDate
            if(noteString != "" || noteContent != "" )
            {
                popupNoteVC.titleString = noteString
                popupNoteVC.contentsString = noteContent
                popupNoteVC.noteId = self.noteId
            }
        }
        else if segue.identifier == "popupForWowkoutNotesSegue"{
            let popupWorkoutNoteVC = segue.destination as! PopupWorkoutViewController
            popupWorkoutNoteVC.selectedDate = selectedDate
        }
        //workout note popup
        
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
