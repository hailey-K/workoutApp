//
//  RunTimerViewController.swift
//  workoutapp
//
//  Created by Hailey on 2018-04-02.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import UIKit

class RunTimerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var RemainingLabel: UILabel!
    @IBOutlet weak var IntervalLabel: UILabel!
    @IBOutlet weak var ElapsedLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var TimerNameString = String()
    var NumberOfSetsString = String()
    var HighIntensityString = String()
    var LowIntensityString = String()
    var TimerId = String()
    var TimerList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        IntervalLabel.text = "1/"+NumberOfSetsString
        ElapsedLabel.text = "00:00"
        TimerLabel.text = HighIntensityString
        RemainingLabel.text = calculateRemaining()
        
        for i in 0..<Int(self.NumberOfSetsString)!*2
        {
            //low intensity
            if i%2==0
            {
               /// TimerList.append(LowIntensityString)
                TimerList.append("low")
            }
            //high intensity
            else
            {
                 //TimerList.append(HighIntensityString)
                     TimerList.append("high")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitBt(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TimerViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = TimerList[indexPath.row]
        if(indexPath.row%2==0){
         cell.backgroundColor = UIColor.red
        }
        else{
            cell.backgroundColor = UIColor.blue
        }
      //  cell.timerIndexPath = indexPath
        return cell
  
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    /*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = fruits[indexPath.row]
        
        return cell
    }
 */
    func calculateRemaining()-> String
    {
        var minForHighIntensity = Int32()
        var minForLowIntensity = Int32()
        var secForHighIntensity = Int32()
        var secForLowIntensity = Int32()
        var totalMin = Int32()
        var totalSec = Int32()
        var Total = String()
        
        let highIntensityArray = HighIntensityString.components(separatedBy: ":")
        let lowIntensityArray = LowIntensityString.components(separatedBy: ":")

        minForHighIntensity = Int32(highIntensityArray[0])!
        secForHighIntensity = Int32(highIntensityArray[1])!
        minForLowIntensity = Int32(lowIntensityArray[0])!
        secForLowIntensity = Int32(lowIntensityArray[1])!
        
        totalSec = (secForHighIntensity+secForLowIntensity)*Int32(NumberOfSetsString)!%60
        totalMin = (minForHighIntensity+minForLowIntensity)*Int32(NumberOfSetsString)!+(secForHighIntensity+secForLowIntensity-totalSec)
        Total = "\(totalMin):\(totalSec)"
        return Total
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
