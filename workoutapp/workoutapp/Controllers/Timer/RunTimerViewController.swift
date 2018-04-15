//
//  RunTimerViewController.swift
//  workoutapp
//
//  Created by hyerim on 2018-04-02.
//  Copyright © 2018 hch_enterprise. All rights reserved.
//

import UIKit

class RunTimerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var RemainingLabel: UILabel!
    @IBOutlet weak var ElapsedLabel: UILabel!
    @IBOutlet weak var IntervalLabel: UILabel!
    @IBOutlet weak var MinutesLabel: UILabel!
    @IBOutlet weak var SecondsLabel: UILabel!
    @IBOutlet weak var IntervalTableView: UITableView!
    @IBOutlet weak var btnStart: UIButton!
    
    var TimerNameString = String()
    var NumberOfSetsString = String()
    var HighIntensityString = String()
    var LowIntensityString = String()
    var TimerId = String()
    var TimerList = [String]()
    var timer = Timer()
    var elapsedTime:Double = 0
    var totalElapsedTime:Double = 0
    let firstIndexPath = IndexPath(row: 0, section: 0)
    let CurrentIntervalLabelText = "CURRENT INTERVAL"

    override func viewDidLoad() {
        super.viewDidLoad()
        IntervalTableView.delegate = self
        IntervalTableView.dataSource = self
        
        IntervalLabel.text = "1/" + NumberOfSetsString
        ElapsedLabel.text = "00:00"
        MinutesLabel.text = "00"
        SecondsLabel.text = "00"
        //RemainingLabel.text = calculateRemaining()
        
        IntervalTableView.selectRow(at: firstIndexPath, animated: false, scrollPosition: .top)
        setRemainingTime()
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(NumberOfSetsString)! * 2 + 1// TimerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IntervalViewCell
        
        if(indexPath.row % 2==0){
            cell.backgroundColor = UIColor.red
            cell.IntensityLabel?.text = "High"
            cell.TimerLabel?.text = HighIntensityString
        }
        else{
            cell.backgroundColor = UIColor.blue
            cell.IntensityLabel?.text = "Low"
            cell.TimerLabel?.text = LowIntensityString
        }
        
        if(indexPath.row == IntervalTableView.numberOfRows(inSection: 0) - 1){
            cell.backgroundColor = UIColor.yellow
            cell.IntensityLabel?.text = "End"
            cell.TimerLabel?.text = ""
            cell.CurrentIntervalLabel?.text = ""
        }
        else if((IntervalTableView.indexPathForSelectedRow == nil && indexPath.row == 0) || IntervalTableView.indexPathForSelectedRow == indexPath){
            cell.CurrentIntervalLabel?.text = CurrentIntervalLabelText
            let timerArray = HighIntensityString.components(separatedBy: ":")
            //let timerArray = getSelectedTimeArray()
            self.setTimerLabel(minutes: Int(timerArray[0])!, seconds:Int(timerArray[1])!)
        }
        else{
            cell.CurrentIntervalLabel?.text = ""
            
        }
        
        /*if((IntervalTableView.indexPathForSelectedRow == nil && indexPath.row == 1) || (IntervalTableView.indexPathForSelectedRow?.row)! + 1 == indexPath.row){
         cell.CurrentIntervalLabel?.text = "UP NEXT"
         
         }*/
        //  cell.timerIndexPath = indexPath
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        elapsedTime = 0
        
        
        for cell in IntervalTableView.visibleCells as! Array<IntervalViewCell> {
            cell.CurrentIntervalLabel?.text = ""
        }
        
        IntervalTableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
        var selectedIndexPath = IntervalTableView.indexPathForSelectedRow;
        let timerArray = getSelectedTimeArray()
        let selector = #selector(delegateTimer)
        timer.invalidate()
        
        let currentInterval = Int((selectedIndexPath?.row)! / 2) + 1
        if(currentInterval <= Int(NumberOfSetsString)!){
            IntervalLabel.text = String(format: "%d/%d", currentInterval, Int(NumberOfSetsString)!)
        }
        
        if(selectedIndexPath?.row == IntervalTableView.numberOfRows(inSection: 0) - 1){
            self.setTimerLabel(minutes: 0, seconds: 0)
            btnStart.setTitle(EStartStopLabel.Start.rawValue, for: .normal)
        }
        else{
            let cell = getSelectedIntervalViewCell()
            cell.CurrentIntervalLabel?.text = CurrentIntervalLabelText
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: selector, userInfo: nil, repeats: true)
            btnStart.setTitle(EStartStopLabel.Stop.rawValue, for: .normal)
            self.setTimerLabel(minutes: Int(timerArray[0])!, seconds:Int(timerArray[1])!)
            
        }
        
        setRemainingTime()
    }
    
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
        setRemainingTime()
        return Total
    }
    
    @objc func setRemainingTime(){
        let selectedIndexPath = IntervalTableView.indexPathForSelectedRow
        let selectedRow = selectedIndexPath!.row
        let totalWorkCount = Int(NumberOfSetsString)! * 2
        var totalIntensityMinute = 0;
        var totalIntensitySecond = 0;
        
        let highIntensityArray = HighIntensityString.components(separatedBy: ":")
        let lowIntensityArray = LowIntensityString.components(separatedBy: ":")
        
        for i in selectedRow..<totalWorkCount{
            if(i % 2 == 0){
                totalIntensityMinute += Int(highIntensityArray[0])!
                totalIntensitySecond += Int(highIntensityArray[1])!
            }
            else{
                totalIntensityMinute += Int(lowIntensityArray[0])!
                totalIntensitySecond += Int(lowIntensityArray[1])!
            }
        }
        
        if(totalIntensitySecond >= 60){
            totalIntensityMinute += totalIntensitySecond / 60
            totalIntensitySecond = totalIntensitySecond % 60
        }
        RemainingLabel.text = String(format: "%02d:%02d", totalIntensityMinute, totalIntensitySecond)
        
        /*while(selectedRow! <= totalWorkCount){
            selectedRow += 1
            
            if(selectedRow % 2 == 0){
                
            }
            else{}
        }
        
        for index in stride(from: (selectedIndexPath?.row)!, to: totalWorkCount, by: 1){
            var a = ""
        }*/
    }
    
    func getSelectedIntervalViewCell() -> IntervalViewCell{
        let selectedIndexPath = IntervalTableView.indexPathForSelectedRow
        let cell = IntervalTableView.cellForRow(at: selectedIndexPath!) as! IntervalViewCell
        
        return cell
    }
    
    @objc func setNextInterval(){
        let nextIndexPath = IndexPath(row: (IntervalTableView.indexPathForSelectedRow?.row)! + 1, section: 0)
        IntervalTableView.selectRow(at: nextIndexPath, animated: false, scrollPosition: .top)
        
        let currentInterval = Int(nextIndexPath.row / 2) + 1
        if(currentInterval <= Int(NumberOfSetsString)!){
            IntervalLabel.text = String(format: "%d/%d", currentInterval, Int(NumberOfSetsString)!)
        }
    }
    
    @objc func getSelectedTimeArray() -> Array<String>{
        let cell = getSelectedIntervalViewCell()
        let timerLabel = cell.TimerLabel
        var timerArray = timerLabel?.text?.components(separatedBy: ":")
        
        if(timerArray?.count == 1){
            timerArray = ["0", "0"]
        }
        
        return timerArray!
    }
    
    @objc func delegateTimer()
    {
        let selectedIndexPath = IntervalTableView.indexPathForSelectedRow
        if(selectedIndexPath != nil && (selectedIndexPath?.row)! < Int(NumberOfSetsString)! * 2){
            var timerArray = getSelectedTimeArray()
            let totalTime = Double(timerArray[0])! * 60 + Double(timerArray[1])!
            elapsedTime += 1
            totalElapsedTime += 1
            
            let minutes = Int(totalElapsedTime / 60)
            let seconds = Int(totalElapsedTime.truncatingRemainder(dividingBy: 60))
            ElapsedLabel.text = String(format: "%02d:%02d", minutes, seconds)
            
            //Remaining time
            let currentRemainingArray = RemainingLabel.text?.components(separatedBy: ":")
            var currentRemainingTime = Double(currentRemainingArray![0])! * 60 + Double(currentRemainingArray![1])!
            currentRemainingTime -= 1
            let remainingMinutes = Int(currentRemainingTime / 60)
            let remainingSeconds = Int(currentRemainingTime.truncatingRemainder(dividingBy: 60))
            RemainingLabel.text = String(format: "%02d:%02d", remainingMinutes, remainingSeconds)
            
            let currentTime = totalTime - elapsedTime
            
            if(currentTime <= 0){
                let listCount = IntervalTableView.numberOfRows(inSection: 0) - 2
                let currentIndex = IntervalTableView.indexPathForSelectedRow?.row
                var cell = getSelectedIntervalViewCell()
                cell.CurrentIntervalLabel?.text = ""
                setNextInterval()
                
                if(listCount == currentIndex){
                    setTimerLabel(minutes: 0, seconds: 0)
                    btnStart.setTitle(EStartStopLabel.Start.rawValue, for: .normal)
                    timer.invalidate()
                }
                else{
                    timerArray = getSelectedTimeArray()
                    self.setTimerLabel(minutes: Int(timerArray[0])!, seconds:Int(timerArray[1])!)
                    cell = self.getSelectedIntervalViewCell()
                    cell.CurrentIntervalLabel?.text = CurrentIntervalLabelText
                    elapsedTime = 0
                }
            }
            else{
                let minutes = Int(currentTime / 60)
                let seconds = Int(currentTime.truncatingRemainder(dividingBy: 60))
                self.setTimerLabel(minutes: minutes, seconds: seconds)
            }
        }
    }
    
    @objc func setTimerLabel(minutes: Int, seconds: Int){
        MinutesLabel.text = String(format: "%02d", minutes)
        SecondsLabel.text = String(format: "%02d", seconds)
    }
    
    @IBAction func clickStartBtn(_ sender: Any) {
        startOrStopInterval()
    }
    
    func startOrStopInterval(){
        var selectedIndexPath = IntervalTableView.indexPathForSelectedRow;
        
        if(btnStart.titleLabel?.text == EStartStopLabel.Start.rawValue){
            if(selectedIndexPath == nil || selectedIndexPath?.row == IntervalTableView.numberOfRows(inSection: 0) - 1){
                initializeInterval()
            }
            
            btnStart.setTitle(EStartStopLabel.Stop.rawValue, for: .normal)
            
            let selector = #selector(delegateTimer)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: selector, userInfo: nil, repeats: true)
        }
        else{
            btnStart.setTitle(EStartStopLabel.Start.rawValue, for: .normal)
            timer.invalidate()
        }
        
        selectedIndexPath = IntervalTableView.indexPathForSelectedRow;
        
        let currentInterval = Int((selectedIndexPath?.row)! / 2) + 1
        if(currentInterval <= Int(NumberOfSetsString)!){
            IntervalLabel.text = String(format: "%d/%d", currentInterval, Int(NumberOfSetsString)!)
        }
    }
    
    func initializeInterval(){
        elapsedTime = 0
        IntervalTableView.selectRow(at: firstIndexPath, animated: false, scrollPosition: .top)
        let timerArray = getSelectedTimeArray()
        self.setTimerLabel(minutes: Int(timerArray[0])!, seconds:Int(timerArray[1])!)
        setRemainingTime()
    }

    @IBAction func clickResetBtn(_ sender: Any) {
        initializeInterval()
        timer.invalidate()
        btnStart.setTitle(EStartStopLabel.Start.rawValue, for: .normal)
        ElapsedLabel.text = "00:00"
        IntervalLabel.text = "1/" + NumberOfSetsString
    }
    
}
