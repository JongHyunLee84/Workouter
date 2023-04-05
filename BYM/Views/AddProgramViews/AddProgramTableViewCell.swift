//
//  AddedWorkoutTableViewCell.swift
//  BYM
//
//  Created by 이종현 on 2023/04/03.
//

import UIKit

class AddProgramTableViewCell: UITableViewCell {

    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI(_ vm: ExerciseViewModel) {
        workoutNameLabel.text = vm.returnName()
        targetLabel.text = vm.returnTarget()
        setsLabel.text = vm.returnSets()
    }

}
