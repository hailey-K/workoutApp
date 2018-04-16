//
//  PopupNoteViewController.swift
//  workoutapp
//
//  Created by hyerim on 2018. 3. 15..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import UIKit

class PopupNoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextField: UITextView!
    var titleString = String()
    var contentsString = String()
    var titlePrevious = String()
    var contentsPrevious = String()
    var selectedDate = String()
    var noteId = Int32()
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text=titleString
        contentsTextField.text = contentsString
        titlePrevious = titleString
        contentsPrevious = contentsString
        // Do any additional setup after loading the view.
    }
    @IBAction func okBt(_ sender: Any) {
        //if contents or title has been changed and previous was empty -> create
        if((titlePrevious != titleTextField.text || contentsTextField.text != contentsPrevious) && titlePrevious == "" &&  contentsPrevious == "")
        {
            if(titleTextField.text == ""&&contentsTextField.text != "")
            {
                createAlert()
            }
            else
            {
                let noteModel = NoteModel.init(noteId:0, title: titleTextField.text!, contents: contentsTextField.text, date:selectedDate, mark: 0)
                NoteDB().insertNote(noteModel:noteModel)
                passValue(noteStringPass:titleTextField.text!,noteStringContents:contentsTextField.text)
                 dismiss(animated: true, completion: nil)
            }
        }
        //if contents or title has been changed but previous title or contents were not empty -> update
        else if((titlePrevious != titleTextField.text || contentsTextField.text != contentsPrevious) &&
            (titlePrevious != "" || contentsPrevious != ""))
        {
            if(titleTextField.text == ""&&contentsTextField.text != "")
            {
                createAlert()
            }
            else
            {
            let noteModel = NoteModel.init(noteId: noteId, title: titleTextField.text!, contents: contentsTextField.text, date:selectedDate, mark: 0)
            NoteDB().updateNote(noteModel: noteModel)
            passValue(noteStringPass:titleTextField.text!,noteStringContents:contentsTextField.text)
            dismiss(animated: true, completion: nil)
            }
        }
        //if contents or title has been changed but current title or contents weere empty -> delete
        else if((titlePrevious != titleTextField.text || contentsTextField.text != contentsPrevious) &&
            (titleTextField.text == "" && contentsTextField.text == ""))
        {
            let noteModel = NoteModel.init(noteId: noteId, title: titleTextField.text!, contents: contentsTextField.text, date:selectedDate, mark: 0)
            NoteDB().deleteNote(noteId: noteId)
            passValue(noteStringPass:"",noteStringContents:"")
            dismiss(animated: true, completion: nil)
        }
        else
        {
             dismiss(animated: true, completion: nil)
        }
    }
    func passValue(noteStringPass:String, noteStringContents:String)
    {
        if(noteStringPass=="")
        {
            if let popVC = presentingViewController as? PopupViewController {
                //noteBt.setTitle(noteString, for: .normal)
                popVC.noteBt.setTitle("Create/Edit note", for: .normal)
                popVC.noteString = "";
                popVC.noteContent = "";
            }
        }
        else
        {
            if let popVC = presentingViewController as? PopupViewController {
                popVC.noteBt.setTitle(noteStringPass, for: .normal)
                popVC.noteString = noteStringPass;
                popVC.noteContent = noteStringContents;
            }
        }
    }
    func createAlert()
    {
        let alert = UIAlertController(title: "Notes", message: "Please enter title", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
