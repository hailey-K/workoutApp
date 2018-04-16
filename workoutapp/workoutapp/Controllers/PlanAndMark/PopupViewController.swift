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
    var workoutNoteId = Int32()
    var markForNote = Int32(0)
    var markForWorkoutNote = Int32(0)
     var workoutName = ""
    @IBOutlet weak var noteCheckBt: UIButton!
    @IBOutlet weak var workoutNoteCheckBt: UIButton!
    
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
                markForNote = noteModel[0].mark
            }
            
           
            
            if(workoutNoteModelList.count > 0){
                for i in 0..<workoutNoteModelList.count{
                    if(workoutNoteModelList[i].isSelected == true){
                        workoutName = workoutNoteModelList[i].workoutName
                        markForWorkoutNote = workoutNoteModelList[i].mark
                        workoutNoteId = workoutNoteModelList[i].noteWorkoutId
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
        if(markForNote==0)//false , uncheck
        {
            noteCheckBt.setImage(UIImage(named:"unCheckmark"), for: .normal)
            noteCheckBt.isSelected = false
        }
        else if(markForNote==1 && noteString != "")// true , check
        {
            noteCheckBt.setImage(UIImage(named:"Checkmark"), for: .normal)
            noteCheckBt.isSelected = true
        }
        if(markForWorkoutNote==0)//false , uncheck
        {
            workoutNoteCheckBt.setImage(UIImage(named:"unCheckmark"), for: .normal)
            workoutNoteCheckBt.isSelected = false
        }
        else if(markForWorkoutNote==1 && workoutName != "")// true, check
        {
            workoutNoteCheckBt.setImage(UIImage(named:"Checkmark"), for: .normal)
            workoutNoteCheckBt.isSelected = true
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func workoutNoteCheckBt(_ sender: Any) {
        if(workoutNoteCheckBt.isSelected == false && workoutName != "")
        {
            workoutNoteCheckBt.setImage(UIImage(named:"Checkmark"), for: .normal)
            workoutNoteCheckBt.isSelected = true
            WorkoutNoteDB().updateWorkoutNoteForMark(mark:1,noteWorkoutId:workoutNoteId)
        }
        else if(workoutNoteCheckBt.isSelected == true && workoutName != "")
        {
            workoutNoteCheckBt.setImage(UIImage(named:"unCheckmark"), for: .normal)
            workoutNoteCheckBt.isSelected = false
            WorkoutNoteDB().updateWorkoutNoteForMark(mark:0,noteWorkoutId:workoutNoteId)
        }
    }
    @IBAction func noteCheckBt(_ sender: Any) {
        if(noteCheckBt.isSelected == false && noteString != "")
        {
            noteCheckBt.setImage(UIImage(named:"Checkmark"), for: .normal)
            noteCheckBt.isSelected = true
            NoteDB().updateNoteForMark(mark:1,noteId:noteId)
        }
        else if(noteCheckBt.isSelected == true && noteString != "")
        {
            noteCheckBt.setImage(UIImage(named:"unCheckmark"), for: .normal)
            noteCheckBt.isSelected = false
              NoteDB().updateNoteForMark(mark:0,noteId:noteId)
        }
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
