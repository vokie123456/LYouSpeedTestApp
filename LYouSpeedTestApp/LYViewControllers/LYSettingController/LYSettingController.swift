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
    
    lazy var settingTableView = UITableView(frame: self.view.frame, style: .grouped)
    let cionArr = ["im_unit","icon_share_green","im_rating","icon_crown","icon_email","im_about"]
    let titleArr = ["速度单位","分享","评分","升级到高级版","意见反馈","关于"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backButton.setImage(UIImage(named:""), for: .normal)
        self.backButton.setTitle("设置", for: .normal)
        self.backButton.frame.size.width = 42
        self.settingTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.settingTableView.delegate = self
        self.settingTableView.dataSource = self
        self.settingTableView.backgroundColor = YCColorMain
        //注册cell重用
        self.settingTableView .register(LYSettingCell.self, forCellReuseIdentifier:"setCellIdentifier")
        self.view.addSubview(settingTableView)
        /** 评分 */
        scoreView.frame = CGRect(x: 40, y: 170, width: Main_Screen_Width-80, height: 170)
        scoreView.layer.cornerRadius = 10
        scoreView.alpha = 0
        self.view.addSubview(scoreView)
        scoreView.closeBlock = {() in
            let opts: UIView.AnimationOptions = [.curveEaseOut]
            UIView.animate(withDuration: 0.4, delay: 0, options: opts, animations: {
                self.scoreView.alpha = 0
            }, completion: { _ in
            })
        }
        scoreView.selStarBlock = {() in
            let opts: UIView.AnimationOptions = [.curveEaseOut]
            UIView.animate(withDuration: 0.4, delay: 0, options: opts, animations: {
                self.scoreView.alpha = 0
                let opts: UIView.AnimationOptions = [.curveEaseIn]
                UIView.animate(withDuration: 0.4, delay: 0, options: opts, animations: {
                    self.submitView.alpha = 1
                }, completion: { _ in
                })
            }, completion: { _ in
            })
        }
        /** 提交反馈 */
        submitView.frame = CGRect(x: 40, y: 140, width: Main_Screen_Width-80, height: 240)
        submitView.layer.cornerRadius = 10
        submitView.alpha = 0
        self.view.addSubview(submitView)
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
                UIView.animate(withDuration: 0.4, delay: 0, options: opts, animations: {
                    self.submitView.alpha = 0
                }, completion: { _ in
                })
                EasyShowTextView.showText("反馈成功", in: self.view)
            }else{
                let opts: UIView.AnimationOptions = [.curveEaseOut]
                UIView.animate(withDuration: 0.4, delay: 0, options: opts, animations: {
                    self.submitView.alpha = 0
                }, completion: { _ in
                })
            }
        }
    }
    //MARK:===========UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"setCellIdentifier") as! LYSettingCell
        cell.selectionStyle = .none
        cell.iocnImageView.image = UIImage(named:"\(cionArr[indexPath.row])")
        cell.titleLable.text = "\(titleArr[indexPath.row])"
        cell.gaintTag(tag: indexPath.row)
        /** 选择单位 */
        cell.callSelBlock = {(_ buttonTag:Int) in
            print("========\(buttonTag)")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==1 {
            /** iOS系统分享 */
            iOSsystemShare()
        }else if indexPath.row==2{
            /** 评分 */
            let opts: UIView.AnimationOptions = [.curveEaseIn]
            UIView.animate(withDuration: 0.4, delay: 0, options: opts, animations: {
                self.scoreView.alpha = 1
            }, completion: { _ in
            })
        }else if indexPath.row==3{
            /** 升级到高级版 */
            let buyMemVC = LYBuyMemController()
            buyMemVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(buyMemVC, animated: true)
        }else if indexPath.row==4{
            /** 发送意见反馈 */
            if let url = URL(string: "mailto:example@example.com") {
            UIApplication.shared.open(url, options: [:]) { (result) in
            }}
        }else if indexPath.row==5{
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
        let urlToShare = URL(string: "http://www.baidu.com")        
        let activityItems = [textToShare, imageToShare as Any, urlToShare as Any] as [Any]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityVC.excludedActivityTypes = [.print, .copyToPasteboard, .assignToContact, .saveToCameraRoll]
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
