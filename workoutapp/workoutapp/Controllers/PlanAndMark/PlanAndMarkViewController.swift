//
//  PlanAndMarkViewController.swift
//  workoutapp
//
//  Created by BSH on 2018. 3. 15..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import UIKit

class PlanAndMarkViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var Calendar: UICollectionView!
    
    let Months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let DaysOfMonth = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var DaysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var currentMonth = String()
    
    var NumberOfEmptyBox = Int() // The number of empty boxes at start of current month
    
    var NextNumberOfEmptyBox = Int() // the same with above but with the next month
    
    var PreviousNumberOfEmptyBox = 0 // the same with above but with previous month
    
    var Direction = 0 // -0 if we are at current month, = 1 if we are in future month, = -1 if we are in a past month
    
    var PositionIndex = 0 // here we will store the above vars of the empty boxes
    
    var LeapYearCounter = 2
    
    var DayCounter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = Months[month]
        
        MonthLabel.text = "\(currentMonth) \(year)"
        GetStartDateDayPosition()
        
        if weekday == 0 {
            weekday = 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        
        switch Direction{
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - NextNumberOfEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox)"
        default:
            fatalError()
            
        }
        print("\(cell.DateLabel.text!)")
        //change color
        cell.backgroundColor = UIColor.red;
    }
    
    @IBAction func Back(_ sender: Any) {
        switch currentMonth {
        case "January":
            month = 11
            year -= 1
            Direction = -1
            
            if LeapYearCounter > 0 {
                LeapYearCounter -= 1
            }
            
            if LeapYearCounter == 0 {
                DaysInMonths[1] = 29
                LeapYearCounter = 4
            }
                
            else{
                DaysInMonths[1] = 28
            }
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
            
        default:
            month -= 1
            Direction = -1
            
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    
    @IBAction func Next(_ sender: Any) {
        switch currentMonth {
        case "December":
            month = 0
            year += 1
            Direction = 1
            
            if LeapYearCounter < 5 {
                LeapYearCounter += 1
            }
            
            if LeapYearCounter == 4 {
                DaysInMonths[1] = 29
            }
            
            if LeapYearCounter == 5{
                LeapYearCounter = 1
                DaysInMonths[1] = 28
            }
            
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        default:
            Direction = 1
            
            GetStartDateDayPosition()
            
            month += 1
            
            currentMonth = Months[month]
            
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    func GetStartDateDayPosition() {
        switch Direction{
        case 0:
            NumberOfEmptyBox = weekday
            DayCounter = day
            while DayCounter > 0 {
                NumberOfEmptyBox = NumberOfEmptyBox - 1
                DayCounter = DayCounter - 1
                if NumberOfEmptyBox == 0{
                    NumberOfEmptyBox = 7
                }
            }
            if NumberOfEmptyBox == 7 {
                NumberOfEmptyBox = 7
            }
            PositionIndex = NumberOfEmptyBox
            
        case 1...:
            NextNumberOfEmptyBox = (PositionIndex + DaysInMonths[month])%7
            PositionIndex = NextNumberOfEmptyBox
        case -1:
            PreviousNumberOfEmptyBox = (7 - (DaysInMonths[month] - PositionIndex)%7)
            if PreviousNumberOfEmptyBox == 7 {
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        switch Direction{
        case 0:
            return DaysInMonths[month] + NumberOfEmptyBox
        case 1...:
            return DaysInMonths[month] + NextNumberOfEmptyBox
        case -1:
            return DaysInMonths[month] + PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
        cell.DateLabel.textColor = UIColor.black
        cell.DateLabel.layer.cornerRadius = 20
        cell.backgroundColor = UIColor.white
        
        if cell.isHidden{
            cell.isHidden = false
        }
        
        switch Direction{
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - NextNumberOfEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox)"
        default:
            fatalError()
            
        }
        
        if Int(cell.DateLabel.text!)! < 1{
            cell.isHidden = true
        }
        
        switch indexPath.row {
        case 6,7,13,14,20,21,27,28,34,35:
            if Int(cell.DateLabel.text!)! > 0 {
                cell.DateLabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day{
            cell.backgroundColor = UIColor.red
            cell.DateLabel.textColor = UIColor.white
        }
        
        return cell
    }
    
    
    
    @IBAction func dateClick(_ sender: Any) {
        
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //notes popup
        if segue.identifier == "popupForNotesSegue"{
            let popupVC = segue.destination as! PopupViewController
            popupVC.noteString = "";
            popupVC.workoutString = "";
        }
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

