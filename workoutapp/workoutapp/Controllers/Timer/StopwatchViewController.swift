//
//  StopwatchControllerViewController.swift
//  workoutapp
//
//  Created by BSH on 2018. 3. 19..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import UIKit

class StopwatchControllerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var milisecondsLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var lapsTableView: UITableView!
    @IBOutlet weak var startStopBt: UIButton!
    @IBOutlet weak var labsResetBt: UIButton!
    
    var lapsList: [String] = []
    var timer = Timer()
    var isTimerRunning = false
    var elapsedTime:Double = 0
    
    enum EStartStopLabel:String
    {
        case Start, Stop
    }
    
    enum ELapResetLabel:String
    {
        case Lap, Reset
    }
    
    @IBAction func labsReset(_ sender: Any) {
        if(labsResetBt.titleLabel?.text == ELapResetLabel.Reset.rawValue)
        {
            startStopBt.setTitle(EStartStopLabel.Start.rawValue, for: .normal)
            labsResetBt.setTitle(ELapResetLabel.Lap.rawValue, for: .normal)
            //stopwatchLabel.text = String("00:00.00")
            labsResetBt.isEnabled = false
            lapsList = []
            elapsedTime = 0
        }
        else
        {
            //let timeText = stopwatchLabel.text!
            
            let timeText = String(format: "%02d:%02d.%02d", minutesLabel.text!, secondsLabel.text!, milisecondsLabel.text!)
            lapsList.append(timeText)
            /*let lapModel = LapModel.init(seq: 0, timeText: timeText)
            StopwatchDB().insertALap(lapModel: lapModel)
            
            let lapList = StopwatchDB().getLapList()*/
        }
        
        lapsTableView.reloadData()
    }
    
    @objc func updateStopwatchLabel()
    {
        elapsedTime += 0.01
        let minutes = Int(elapsedTime / 60)
        let seconds = Int(elapsedTime.truncatingRemainder(dividingBy: 60))
        let hundredOfSeconds = Int((elapsedTime * 100).truncatingRemainder(dividingBy: 100))
        minutesLabel.text = String(format: "%02d", minutes)
        secondsLabel.text = String(format: "%02d", seconds)
        milisecondsLabel.text = String(format: "%02d", hundredOfSeconds)
        stopwatchLabel.text = String(format: "%02d:%02d.%02d", minutes, seconds, hundredOfSeconds)
    }
    
    @IBAction func clickStartStopBt(_ sender: Any) {
        if(startStopBt.titleLabel?.text == EStartStopLabel.Start.rawValue)
        {
            startStopBt.setTitle(EStartStopLabel.Stop.rawValue, for: .normal)
            
            if(labsResetBt.titleLabel?.text == ELapResetLabel.Reset.rawValue)
            {
                labsResetBt.setTitle(ELapResetLabel.Lap.rawValue, for: .normal)
            }
            else if(labsResetBt.isEnabled == false)
            {
                labsResetBt.isEnabled = true;
            }
            
            let selector = #selector(updateStopwatchLabel)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: selector, userInfo: nil, repeats: true)

        }
        else
        {
            startStopBt.setTitle(EStartStopLabel.Start.rawValue, for: .normal)
            
            if(labsResetBt.titleLabel?.text == ELapResetLabel.Lap.rawValue)
            {
                labsResetBt.setTitle(ELapResetLabel.Reset.rawValue, for: .normal)
            }
            
            timer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lapsTableView.delegate = self
        lapsTableView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = lapsTableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text=lapsList[indexPath.row]
        
        return cell!
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
