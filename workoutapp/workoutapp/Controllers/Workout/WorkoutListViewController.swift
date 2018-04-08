//
//  WorkoutListViewController.swift
//  workoutapp
//
//  Created by BSH on 2018. 3. 15..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import UIKit

class WorkoutListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var workoutList: UITableView!
    var workoutListName = WorkoutDB().getWorkoutNameList()
    var selectedWorkoutId = Int32()
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutList.delegate = self
        workoutList.dataSource = self
        let recognizer:UILongPressGestureRecognizer=UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        workoutList.addGestureRecognizer(recognizer)
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutListName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workoutList.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text=workoutListName[indexPath.row].WorkoutName
        return cell!
        //i am testing
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //timer detail, edit timer
        if segue.identifier == "createWorkoutSegue"{
            let workoutItemListVC = segue.destination as! WorkoutItemListViewController
            workoutItemListVC.BtText = "Create"
            // }
        }
        
        else if segue.identifier == "editWorkoutSegue"{
            let workoutItemListVC = segue.destination as! WorkoutItemListViewController
            if let indexPath = self.workoutList.indexPathForSelectedRow {
                workoutItemListVC.WorkoutNameString = workoutListName[indexPath.row].WorkoutName
                workoutItemListVC.WorkoutIdString = String(workoutListName[indexPath.row].WorkoutId)
                workoutItemListVC.BtText = "Save"
            }
        }
    }
    @IBAction func longPress(_ recognizer: UILongPressGestureRecognizer) {
        let point = recognizer.location(in: workoutList)
        
        if recognizer.state == UIGestureRecognizerState.began
        {
            let index = workoutList.indexPathForRow(at: point)
            self.selectedWorkoutId = Int32(workoutListName[index!.row].WorkoutId)
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
        let alert = UIAlertController(title: "Do you want to delete the workout?", message: "If you click 'YES', it will permanently delete.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            (action) in
            WorkoutDB().deleteWorkout(WorkoutId: self.selectedWorkoutId)
            self.workoutListName = WorkoutDB().getWorkoutNameList()
            self.workoutList.reloadData()
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
