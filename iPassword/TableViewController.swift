//
//  TableViewController.swift
//  iPassword
//
//  Created by Channing Kuo on 20/02/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit

class TableViewController: TableViewPopController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        /// setup iOS 11 NavigationBar style
        self.navigationItem.title = "iPassword"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 246 / 255, green: 225 / 255, blue: 127 / 255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = {[
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "Zapfino", size: 18.0)!
            ]}()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
            self.navigationController?.navigationBar.largeTitleTextAttributes = {[
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.font: UIFont(name: "Zapfino", size: 20.0)!
                ]}()
        } else {
            // Fallback on earlier versions
        }
        let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(TableViewController.newone))
        self.navigationItem.setRightBarButton(rightButtonItem, animated: true)
        
        /// setup viewcontroller pop up
        let popedView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 100))
        popedView.backgroundColor = UIColor(red: 246 / 255, green: 225 / 255, blue: 127 / 255, alpha: 1)
        // setup shadow
        popedView.layer.shadowColor = UIColor.black.cgColor
        popedView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        popedView.layer.shadowOpacity = 0.8
        popedView.layer.shadowRadius = 5
        
        self.createPopViewController(self.navigationController!, popView: popedView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// setup iOS 11 NavigationBar style
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
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
        
    }
    
    /// add new
    @objc func newone() -> Void {
        self.push()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
