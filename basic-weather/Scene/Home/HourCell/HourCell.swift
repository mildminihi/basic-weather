//
//  HourCell.swift
//  basic-weather
//
//  Created by Supanat Wanroj on 22/4/2567 BE.
//

import Foundation
import UIKit

struct HourCellViewModel {
    let time: String
    let temp: String
    let dayCondition: DayCondition
}

class HourCell: UICollectionViewCell {
    static let identifier = "HourCell"
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dayConditionIcon: UIImageView!
    
    func setUpData(data: HourCellViewModel) {
        timeLabel.text = data.time
        tempLabel.text = data.temp
    }
}
