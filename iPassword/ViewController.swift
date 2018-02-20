//
//  ViewController.swift
//  iPassword
//
//  Created by Channing Kuo on 18/02/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var tableview: UITableView?
    @IBOutlet weak var navigationBar: UINavigationBar!
    /// NavigationBar向上的偏移量
    var marginTop: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        statusBarView.backgroundColor = UIColor(red: 246 / 255, green: 225 / 255, blue: 127 / 255, alpha: 1)
        
        self.marginTop = self.navigationBar.frame.height + 20
        if UIDevice.current.deviceName == "iPhone X" || UIDevice.current.deviceName == "Simulator" {
            self.navigationBar.frame.origin.y = 44
            self.marginTop = self.navigationBar.frame.height + 44
            
            statusBarView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        }
        
        self.view.addSubview(statusBarView)
        self.setNeedsStatusBarAppearanceUpdate()
        
        self.tableview = UITableView(frame: CGRect(x: 0, y: self.marginTop, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - self.marginTop), style: .plain)
        self.tableview?.delegate = self
        self.tableview?.dataSource = self
        self.view.addSubview(self.tableview!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.launchAnumation()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellIdentifier")
        }
        cell?.textLabel?.text = String(indexPath.row)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// 滚动试图页面，改变NavigationBar形态、ToolBar等控件
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.tableview?.contentOffset.y)! >= CGFloat(44.0) {
            if #available(iOS 11.0, *) {
                self.navigationBar.prefersLargeTitles = false
            } else {
                // Fallback on earlier versions
            }
        } else {
            if #available(iOS 11.0, *) {
                self.navigationBar.prefersLargeTitles = true
            } else {
                // Fallback on earlier versions
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// load custom launch animation
    func launchAnumation() -> Void {
        let viewController = UIStoryboard.init(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "LaunchScreen")
        let launchView = viewController.view
        let mainWindow = UIApplication.shared.keyWindow
        launchView?.frame = (UIApplication.shared.keyWindow?.frame)!
        mainWindow?.addSubview(launchView!)
        
        // icon animation
        let icon = UIImageView(frame: CGRect(x: ((launchView?.frame.width)! - 160) / 2.0, y: ((launchView?.frame.height)! - 175) / 2.0, width: 160.0, height: 175.0))
        icon.image = UIImage(named: "launch-icon")
        launchView?.addSubview(icon)
        // create animation
        let rotator = CABasicAnimation(keyPath: "transform.rotation.y")
        let timingFunc = CAMediaTimingFunction(name: "easeInEaseOut")
        // set up animation property
        rotator.fromValue = 0
        rotator.toValue = CGFloat.pi * 2
        rotator.timingFunction = timingFunc
        rotator.repeatCount = MAXFLOAT
        rotator.duration = 0.7
        rotator.isRemovedOnCompletion = false
        // add animation into layer
        icon.layer.add(rotator, forKey: nil)
        
        // TODO add custom image view into current view at the launch
        
        // remove the launch view
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut){
            launchView?.alpha = 0.0
            launchView?.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0, 2.0, 1.0)
        }
        animator.addCompletion { (position) in
            launchView?.removeFromSuperview()
        }
        animator.startAnimation(afterDelay: 3.0)
    }
}

