//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by linyuta on 2019/8/4.
//  Copyright © 2019 UTA. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionImage: UIImageView!
    
    var isEditing: Bool = false {
        didSet {
            selectionImage.isHidden = !isEditing
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                selectionImage.image = isSelected ? UIImage(named: "Checked") :
                UIImage(named: "Unchecked")
            }
        }
    }
}
