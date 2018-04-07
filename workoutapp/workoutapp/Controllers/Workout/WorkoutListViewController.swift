//
//  WorkoutListViewController.swift
//  workoutapp
//
//  Created by BSH on 2018. 3. 15..
//  Copyright © 2018년 hch_enterprise. All rights reserved.
//

import UIKit

class WorkoutListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var workoutListView: UITableView!
    
    let workoutListName = ["sample workout1","sameple workout2","sample workout3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutListView.delegate = self
        workoutListView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutListName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workoutListView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text=workoutListName[indexPath.row]
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
