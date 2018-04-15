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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text=titleString
        contentsTextField.text = contentsString
        // Do any additional setup after loading the view.
    }
    @IBAction func okBt(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
