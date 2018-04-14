//
//  RowTableViewCell.swift
//  iPassword
//
//  Created by Channing Kuo on 25/03/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit
import Foundation
import SQLite

class RowTableViewCell : UITableViewCell{
    var title, account, modifytime: UILabel!
    var iconView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.default
        
        self.iconView = UIImageView.init(image: UIImage.init(named: "default_icon.png"))
        contentView.addSubview(self.iconView)
        
        self.title = UILabel()
        self.title.font = UIFont.boldSystemFont(ofSize: 16)
        self.title.textColor = .black
        self.title.textAlignment = .left
        self.title.backgroundColor = .clear
        contentView.addSubview(self.title)
        
        self.account = UILabel()
        self.account.font = UIFont.boldSystemFont(ofSize: 14)
        self.account.textColor = .gray
        self.account.textAlignment = .left
        self.account.backgroundColor = .clear
        contentView.addSubview(self.account)
        
        self.modifytime = UILabel()
        self.modifytime.font = UIFont.boldSystemFont(ofSize: 14)
        self.modifytime.textColor = .gray
        self.modifytime.textAlignment = .right
        self.modifytime.backgroundColor = .clear
        contentView.addSubview(self.modifytime)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.iconView.frame = CGRect(x: 15, y: 14.5, width: 36, height: 36)
        self.title.frame = CGRect(x: 61, y: 10, width: contentView.bounds.width - 165, height: 26)
        self.account.frame = CGRect(x: 61, y: 32, width: contentView.bounds.width - 65, height: 24)
        self.modifytime.frame = CGRect(x: contentView.bounds.width - 160, y: 20, width: 150, height: 26)
    }
    
    public func setRowData(row: SQLite.Row) {
        self.iconView.image = UIImage.init(named: row[SQLiteUtils.icon])
        self.title.text = row[SQLiteUtils.title]
        self.account.text = row[SQLiteUtils.account]
        self.modifytime.text = DateTimeUtils.dateTimeFormatter(dateTime: DateTimeUtils.dateFromString(dateString: row[SQLiteUtils.modifytime]), isShowTime: false)
    }
}
