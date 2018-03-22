//
//  NYTBaseTableViewCell.swift
//  NYTimesArticles
//
//  Created by Soumen Das on 22/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import UIKit

/**
 All UITableViewCell should be inherited from this BaseCell class. So that in case of any changes required in all the cell only changes in this base class will solve the purpose.
 */
class NYTBaseTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
