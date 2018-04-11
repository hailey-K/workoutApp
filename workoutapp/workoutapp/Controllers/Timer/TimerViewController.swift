//
//  TimerViewController.swift
//  workoutapp
//
//  Created by hyerim on 2018-03-31.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    @IBOutlet weak var lowIntensity: UITextField!
    @IBOutlet weak var highIntensity: UITextField!
    @IBOutlet weak var numberOfSets: UITextField!
    @IBOutlet weak var timerName: UITextField!
    
    @IBOutlet weak var Bt: UIButton!
    var TimerNameString = String()
    var NumberOfSetsString = String()
    var HighIntensityString = String()
    var LowIntensityString = String()
    var TimerId = String()
    var BtText = String()
    
   // let editTableId : TimerModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timerName.text = TimerNameString
        numberOfSets.text = NumberOfSetsString
        lowIntensity.text = LowIntensityString
        highIntensity.text = HighIntensityString
        Bt.setTitle(BtText, for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func lowIntensityAction(_ sender: Any) {
        
      //  print("textfield : '\(highIntensity.text)'")
    }
    
    @IBAction func highIntensityAction(_ sender: Any) {
          print("textfield : '\(highIntensity.text)'")
    }
    
    @IBAction func createBt(_ sender: Any) {
        if(BtText=="Create")
        {
            let timerModel = TimerModel.init(TimerId: 0, TimerName: timerName.text!,NumberOfSets : Int32(numberOfSets.text!)!, HighInetensity: highIntensity.text!, LowIntensity: lowIntensity.text!)
            TimerDB().insertTimer(timerModel: timerModel)
        }
        else if(BtText=="Save")
        {
            let timerModel = TimerModel.init(TimerId: Int32(TimerId)!,TimerName: timerName.text!,NumberOfSets : Int32(numberOfSets.text!)!, HighInetensity: highIntensity.text!, LowIntensity: lowIntensity.text!)
            TimerDB().updateTimer(timerModel:timerModel)
        }
       // let timerList = TimerDB().getTimerNameList()
       // let next:TimerListControllerViewController = TimerListControllerViewController()
       // self.TimerViewController(next, animated: true, completion: nil)
        
     /*  for (index, element) in timerList.enumerated() {
            print(index, ":", element)
 
         }*/
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
