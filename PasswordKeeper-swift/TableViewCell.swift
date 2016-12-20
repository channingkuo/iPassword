//
//  TableViewCell.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2016/12/19.
//  Copyright © 2016年 Channing Kuo. All rights reserved.
//

import UIKit

class TableViewCell : UITableViewCell{
    var caption, account, lastEditTime: UILabel!
    var iconView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.default
        
        iconView = UIImageView.init(image: UIImage.init(named: ""))
        contentView.addSubview(iconView)
        
        caption = UILabel()
        caption.font = UIFont.boldSystemFont(ofSize: 16)
        caption.textColor = UIColor.black
        caption.textAlignment = NSTextAlignment.left
        caption.backgroundColor = UIColor.clear
        contentView.addSubview(caption)
        
        account = UILabel()
        account.font = UIFont.boldSystemFont(ofSize: 16)
        account.textColor = UIColor.gray
        account.textAlignment = NSTextAlignment.left
        account.backgroundColor = UIColor.clear
        contentView.addSubview(account)
        
        lastEditTime = UILabel()
        lastEditTime.font = UIFont.boldSystemFont(ofSize: 16)
        lastEditTime.textColor = UIColor.gray
        lastEditTime.textAlignment = NSTextAlignment.left
        lastEditTime.backgroundColor = UIColor.clear
        
        contentView.addSubview(lastEditTime)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconView.frame = CGRect(x: 15, y: 14.5, width: 36, height: 36)
        caption.frame = CGRect(x: 61, y: 10, width: contentView.bounds.width - 165, height: 26)
        account.frame = CGRect(x: 61, y: 32, width: contentView.bounds.width - 65, height: 24)
        lastEditTime.frame = CGRect(x: contentView.bounds.width - 90, y: 10, width: 80, height: 26)
    }
    
    func updateUIInformation(){
        
    }
}



