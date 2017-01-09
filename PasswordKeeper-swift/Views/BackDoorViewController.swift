//
//  BackDoorViewController.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2017/1/9.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit
import Alamofire

class BackDoorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "BackDoor"
        view.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 255, blue: 255, alpha: 1)
        
        // 开启后门
        let itemButton = UIBarButtonItem(title: "OpenDoor", style: .plain, target: self, action: #selector(BackDoorViewController.openBackDoor))
        navigationItem.setRightBarButton(itemButton, animated: false)
    }
    
    func openBackDoor() {
        print("开始执行后门程序...")
        
        var serverAddress: String = ""
        let inputAlert = UIAlertController.init(title: "Server Address", message: nil, preferredStyle: .alert)
        inputAlert.addTextField(configurationHandler: {(serverAddress: UITextField!) in
            serverAddress.placeholder = "Server Address"
            serverAddress.keyboardType = UIKeyboardType.URL
            serverAddress.text = "http://wx.rektec.com.cn:28080/"
        })
        let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { action in
            // 添加菊花
            let activityIndicator = UIActivityIndicatorView.init(frame: CGRect(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2, width: 10, height: 10))
            activityIndicator.activityIndicatorViewStyle = .gray
            activityIndicator.hidesWhenStopped = true
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            serverAddress = (inputAlert.textFields?[0].text)!
            let headers: HTTPHeaders = [
                "Authorization": "Basic eyJhbGciOiJkaXIiLCJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYXBwaWQiOiJYY3JtIn0..y9zgR5dYviP3Ppgg_j7l6Q.HLKeT2nAc51upvcCdL0mO-dM3Fgc7cjQ6rm35F19RJVLY-paGLo43b7e9qpQ6Aiop2MiZsd6LAOM5FsCJjx9MQWLtpQ6Z68lxtxTPnZlPS9rJ40lbaeD-v2AjwtGq3-IG5EWPB6rZdzdrtkmYb9CxldQsBgAtgZcZaVOLmiG88gM_eO7ZtSRHz4sWEjJusPN.av6Eoh6x6JErWuwh10Jk4w",
                "Accept": "application/json",
                "Content-Type": "application/json"
            ]
            let parameters: Parameters = ["syncTime": "2016-11-09 11:27:19"]
            let url = serverAddress + "api/Common/GetWeChatMenu?syncTime="
            Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseJSON(completionHandler: {
                response in
                // 去掉菊花
                activityIndicator.stopAnimating()
                
                print(response.request ?? "")
                print(response.response ?? "")
                print(response.data ?? "")
                print(response.result)
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            })
        }
        inputAlert.addAction(actionOK)
        present(inputAlert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
