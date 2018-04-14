//
//  EmptyTableViewCell.swift
//  iPassword
//
//  Created by Channing Kuo on 2018/4/15.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit
import Foundation

class EmptyTableViewCell : UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.default
        
//        let blankView = UIView(frame: self.frame)
        let emptyText = UILabel(frame: CGRect(x: 0, y: 75, width: self.frame.size.width, height: 30))
        emptyText.text = "No record，click to add~~~"
        emptyText.textAlignment = .center
        emptyText.textColor = .lightGray
        emptyText.attributedText = NSAttributedString(string: (emptyText.text)!, attributes:[NSAttributedStringKey.font: UIFont(name: "Zapfino", size: 12.0)!])
//        blankView.backgroundColor = .white
//        blankView.addSubview(emptyText)
        contentView.addSubview(emptyText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        self.iconView.frame = CGRect(x: 15, y: 14.5, width: 36, height: 36)
    }
}
