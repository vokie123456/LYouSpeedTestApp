//
//  LYSettingController.swift
//  LYouSpeedTestApp
//
//  Created by grx on 2018/12/27.
//  Copyright © 2018 grx. All rights reserved.
//

import UIKit

class LYSettingController: LYBaseController,UITableViewDelegate,UITableViewDataSource {
    var selTitle = NSString()
    let scoreView = LYScoreVeiw()
    let submitView = LYSubmitView()
    
    lazy var settingTableView = UITableView(frame: CGRect(x: 0, y: 0, width: Main_Screen_Width, height: Main_Screen_Height), style: .grouped)
    let cionArr = [["im_unit"],["icon_share_green","im_rating"],["icon_crown","icon_email"],["im_about"]]
    let titleArr = [["速度单位"],["分享","评分"],["升级到高级版","意见反馈"],["关于"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        self.backButton.isHidden = true
        self.settingTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.settingTableView.delegate = self
        self.settingTableView.dataSource = self
        self.settingTableView.backgroundColor = YCColorGray
        //注册cell重用
        self.settingTableView .register(LYSettingCell.self, forCellReuseIdentifier:"setCellIdentifier")
        self.view.addSubview(settingTableView)
        /** 评分 */
        scoreView.frame = CGRect(x: 0, y: 0, width: Main_Screen_Width, height: Main_Screen_Height)
        scoreView.alpha = 0
        let window: UIWindow? = UIApplication.shared.keyWindow
        window!.addSubview(scoreView)
        scoreView.closeBlock = {() in
            let opts: UIView.AnimationOptions = [.curveEaseOut]
            UIView.animate(withDuration: 0.1, delay: 0, options: opts, animations: {
                self.scoreView.alpha = 0
            }, completion: { _ in
            })
        }
        scoreView.selStarBlock = {() in
            let opts: UIView.AnimationOptions = [.curveEaseOut]
            UIView.animate(withDuration: 0.1, delay: 0, options: opts, animations: {
                self.scoreView.alpha = 0
                let opts: UIView.AnimationOptions = [.curveEaseIn]
                UIView.animate(withDuration: 0.1, delay: 0, options: opts, animations: {
                    self.submitView.alpha = 1
                }, completion: { _ in
                })
            }, completion: { _ in
            })
        }
        /** 提交反馈 */
        submitView.frame = CGRect(x: 0, y: 0, width: Main_Screen_Width, height: Main_Screen_Height)
        submitView.layer.cornerRadius = 10
        submitView.alpha = 0
        let subwindow: UIWindow? = UIApplication.shared.keyWindow
        subwindow!.addSubview(submitView)
        submitView.selSubmitBlock = {(title:NSString) in
            self.selTitle = title
        }
        submitView.submitBlock = {(tag:NSInteger) in
            if tag==100 {
                if (self.selTitle.length==0){
                    return ;
                }
                /** 提交 */
                let opts: UIView.AnimationOptions = [.curveEaseOut]
                UIView.animate(withDuration: 0.1, delay: 0, options: opts, animations: {
                    self.submitView.alpha = 0
                }, completion: { _ in
                })
                EasyShowTextView.showText("反馈成功")
            }else{
                let opts: UIView.AnimationOptions = [.curveEaseOut]
                UIView.animate(withDuration: 0.1, delay: 0, options: opts, animations: {
                    self.submitView.alpha = 0
                }, completion: { _ in
                })
            }
        }
        /** 广告位 */
        let adboadView = GADBannerView()
        self.view.addSubview(adboadView)
        adboadView.snp.makeConstraints { (make) in
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.bottom.equalTo(-5);
            make.height.equalTo(50);
        }
        adboadView.adUnitID = LYDetailADId;
        adboadView.rootViewController = self;
        adboadView.load(GADRequest())
    }
    //MARK:===========UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionArray = self.titleArr[section]
        return sectionArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"setCellIdentifier") as! LYSettingCell
        cell.selectionStyle = .none
        let sectionIconArray = cionArr[indexPath.section]
        let sectionTitleArray = titleArr[indexPath.section]
        cell.iocnImageView.image = UIImage(named:"\(sectionIconArray[indexPath.row])")
        cell.titleLable.text = "\(sectionTitleArray[indexPath.row])"
        cell.gaintTag(tag: indexPath.section*10+indexPath.row)
        /** 选择单位 */
        cell.callSelBlock = {(_ buttonTag:Int) in
            print("========\(buttonTag)")
            if buttonTag==10 {
                UserDefaults.standard.set("no", forKey:"isSelKbps")
            }else{
                UserDefaults.standard.set("yes", forKey:"isSelKbps")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.section*10+indexPath.row
        if index==10 {
            /** iOS系统分享 */
            iOSsystemShare()
        }else if index==11{
            /** 评分 */
            let opts: UIView.AnimationOptions = [.curveEaseIn]
            UIView.animate(withDuration: 0.1, delay: 0, options: opts, animations: {
                self.scoreView.alpha = 1
            }, completion: { _ in
            })
        }else if index==20{
            /** 升级到高级版 */
            let buyMemVC = LYBuyMemController()
            buyMemVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(buyMemVC, animated: true)
        }else if index==21{
            /** 发送意见反馈 */
            if let url = URL(string: "mailto:grx0917@sina.com") {
            UIApplication.shared.open(url, options: [:]) { (result) in
            }}
        }else if index==30{
            /** 关于我们 */
            let aboutUsVC = LYAboutUsController()
            aboutUsVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(aboutUsVC, animated: true)
        }
    }
    
    //MARK:============iOS系统分享=============
    func iOSsystemShare() {
        let textToShare = "我正在使用全网测"
        let imageToShare = UIImage(named: "shareImage")
        let urlToShare = URL(string: "http://itunes.apple.com/lookup?id=\(APPSTOREID)")
        let activityItems = [textToShare, imageToShare as Any, urlToShare as Any] as [Any]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
//        activityVC.excludedActivityTypes = [.print, .copyToPasteboard, .assignToContact, .saveToCameraRoll, .message]
        present(activityVC, animated: true)
        activityVC.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
            if completed {
                print("completed")
            } else {
                print("cancled")
            }
        }
    }
}
