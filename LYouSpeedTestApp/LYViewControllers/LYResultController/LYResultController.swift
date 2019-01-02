//
//  LYResultController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/27.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYResultController: LYBaseController,UITableViewDelegate,UITableViewDataSource {
    lazy var resultTableView = UITableView(frame: CGRect(x: 0, y: 10, width: Main_Screen_Width, height: Main_Screen_Height-NaviBarHeight-SafeBottomMargin-10-50-40), style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.setImage(UIImage(named:""), for: .normal)
        self.backButton.setTitle("结果", for: .normal)
        self.backButton.frame.size.width = 42
        self.rightView.isHidden = false
        self.resultTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.resultTableView.delegate = self
        self.resultTableView.dataSource = self
        self.resultTableView.backgroundColor = YCColorMain
        //注册cell重用
        self.resultTableView .register(LYResultCell.self, forCellReuseIdentifier:"ResultCellIdentifier")
        self.view.addSubview(resultTableView)
        /** 升级到高级版 */
        self.view.addSubview(self.updateView)
        self.updateView.updateBlock = {() in
            /** 升级到高级版 */
            let buyMemVC = LYBuyMemController()
            buyMemVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(buyMemVC, animated: true)
        }
    }
    //MARK:===========UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = LYResultHeadView()
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ResultCellIdentifier") as! LYResultCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = LYResultDetailController()
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK:=========清除列表
    @objc override func clearButtonClick(){
        
    }
    
    lazy var updateView:LYUpgradeView = {
        let  updateView = LYUpgradeView(frame: CGRect(x: 0, y: Main_Screen_Height-SafeBottomMargin-50-kTabBarHeight-NaviBarHeight, width: Main_Screen_Width, height: 50))
        return updateView
    }()
    
}
