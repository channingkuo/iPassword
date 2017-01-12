//
//  BackDoorTableViewCell.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2017/1/12.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit
import SwiftyJSON

class BackDoorTableViewCell : UITableViewCell {
    var caption, account, password: UILabel!
    var iconView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCellSelectionStyle.default
        
        iconView = UIImageView.init(image: UIImage.init(named: "default_icon.png"))
        contentView.addSubview(iconView)
        
        caption = UILabel()
        caption.font = UIFont.boldSystemFont(ofSize: 16)
        caption.textColor = .black
        caption.textAlignment = .left
        caption.backgroundColor = .clear
        contentView.addSubview(caption)
        
        account = UILabel()
        account.font = UIFont.boldSystemFont(ofSize: 14)
        account.textColor = .gray
        account.textAlignment = .left
        account.backgroundColor = .clear
        contentView.addSubview(account)
        
        password = UILabel()
        password.font = UIFont.boldSystemFont(ofSize: 14)
        password.textColor = .gray
        password.textAlignment = .left
        password.backgroundColor = .clear
        
        contentView.addSubview(password)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconView.frame = CGRect(x: 15, y: 26, width: 40, height: 40)
        caption.frame = CGRect(x: 71, y: 10, width: contentView.bounds.width - 175, height: 26)
        account.frame = CGRect(x: 71, y: 32, width: contentView.bounds.width - 75, height: 24)
        password.frame = CGRect(x: 71, y: 56, width: contentView.bounds.width - 75, height: 24)
    }
    
    public func updateUIInformation(info: JSON) {
        iconView.image = UIImage.init(named: info["lconName"].stringValue)
        caption.text = info["caption"].stringValue
        account.text = info["account"].stringValue
        password.text = info["password"].stringValue
    }
}
