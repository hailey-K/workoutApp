//
//  TimerListControllerViewController.swift
//  workoutapp
//
//  Created by hyerim on 2018. 3. 15..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import UIKit

class TimerListControllerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var timerListView: UITableView!
    var timerListName = TimerDB().getTimerNameList()
    var timerId = String()
    var timerName = String()
    var numberOfSets = String()
    var lowIntensity = String()
    var highIntensity = String()
    var selectedTimerId = Int32()
    override func viewDidLoad() {
        super.viewDidLoad()
        timerListView.delegate = self
        timerListView.dataSource = self
        //Long Press
        let recognizer:UILongPressGestureRecognizer=UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        timerListView.addGestureRecognizer(recognizer)
        
     //   let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
    //    longPressGesture.minimumPressDuration = 0.5
    //    longPressGesture.delegate = self
   //     self.timerListView.addGestureRecognizer(longPressGesture)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerListName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timerListView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TimerViewCell
        cell.titleLabel.text = timerListName[indexPath.row].TimerName
        cell.timerIndexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  let longPressGesture = UILongPressGestureRecognizer(target: self, action:#selector(self.longPress))
       // let cell = timerListView.dequeueReusableCell(withIdentifier: "cell")
       // cell?.addGestureRecognizer(longPressGesture)
  
    }
    /*
    func longPress(longPressGesture:UILongPressGestureRecognizer) {
        let p = longPressGesture.location(in: self.timerListView)
        let indexPath = self.timerListView.indexPathForRow(at: p)
        if indexPath == nil {
            print("Long press on table view, not row.")
        }
        else if (longPressGesture.state == UIGestureRecognizerState.began) {
            print("Long press on row, at \(indexPath!.row)")
        }
    }
    */
    @IBAction func longPress(_ recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: timerListView)
        
        if recognizer.state == UIGestureRecognizerState.began
        {
            let index = timerListView.indexPathForRow(at: point)
            self.selectedTimerId = Int32(timerListName[index!.row].TimerId)
            createAlert()
            //if(self.delete==true)
           // {
              //  let timerModel = TimerModel.init(TimerId:Int32(timerListName[indexPath].TimerId)!,TimerName: timerListName[indexPath].TimerName,NumberOfSets : Int32(timerListName[indexPath].NumberOfSets)!, HighInetensity: timerListName[indexPath].HighInetensity, LowIntensity: timerListName[indexPath].LowIntensity)
                //TimerDB().deleteTimer(TimerId:timerId)
            //}
        }
            //cell.isHighlighted
            else {
                return
        }
    }
    func createAlert()
    {
        let alert = UIAlertController(title: "Do you want to delete the timer?", message: "If you click 'YES', it will permanently delete.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            (action) in
            TimerDB().deleteTimer(TimerId:self.selectedTimerId)
            self.timerListName = TimerDB().getTimerNameList()
            self.timerListView.reloadData()
          //  self.delete = true
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
            (action) in
          //  self.delete = false
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
     /*
    @objc func longPress()
    {
        let alert = UIAlertController(title:"TITLE",message:"CONTENT",preferredStyle:.alert)
    }
 */
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //timer detail, edit timer
        if segue.identifier == "timerCellSegue"{
            let timerVC = segue.destination as! TimerViewController
            
            var superview = (sender as AnyObject).superview
            while let view = superview, !(view is UITableViewCell) {
                superview = view?.superview
            }
            guard let cell = superview as? TimerViewCell else {
                print("button is not contained in a table view cell")
                return
            }
            let  indexPath = self.timerListView.indexPath(for: cell)!
          
           // if segue.identifier == timerRunCellSegue
            //if let indexPath = self.timerListView.indexPathForSelectedRow {
            
          //  if let indexPath = self.timerListView.indexPath(for: cell) {
                timerVC.TimerNameString = timerListName[indexPath.row].TimerName
                timerVC.NumberOfSetsString = String(timerListName[indexPath.row].NumberOfSets)
                timerVC.LowIntensityString = timerListName[indexPath.row].LowIntensity
                timerVC.HighIntensityString = timerListName[indexPath.row].HighInetensity
                timerVC.TimerId = String(timerListName[indexPath.row].TimerId)
                timerVC.BtText = "Save"
           // }
 
        }
        //create timer
        else if segue.identifier == "createTimerSegue"{
         let timerVC = segue.destination as! TimerViewController
            timerVC.LowIntensityString = "00:00"
          timerVC.HighIntensityString = "00:00"
          timerVC.BtText = "Create"
        }
        //run timer
        else if segue.identifier == "timerRunCellSegue"
        {
            let runTimerVC = segue.destination as! RunTimerViewController
            if let indexPath = self.timerListView.indexPathForSelectedRow {
                runTimerVC.TimerNameString = timerListName[indexPath.row].TimerName
                runTimerVC.NumberOfSetsString = String(timerListName[indexPath.row].NumberOfSets)
                runTimerVC.LowIntensityString = timerListName[indexPath.row].LowIntensity
                runTimerVC.HighIntensityString = timerListName[indexPath.row].HighInetensity
                runTimerVC.TimerId = String(timerListName[indexPath.row].TimerId)
            }
        }
    }
}
